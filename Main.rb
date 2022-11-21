require_relative 'Tools'
include Tools

def pas_rad(param_hash)
  x0 = 0
  forward = backward = stopped = 0
  tet0 = param_hash.dig(:tet0)
  cos_tet0 = param_hash.dig(:cos_tet0)
  h = param_hash.dig(:h)
  mu = param_hash.dig(:mu)
  l_av = param_hash.dig(:lv)
  pa = param_hash.dig(:pa)
  sp = param_hash.dig(:sp)
  ns = param_hash.dig(:ns)

  start_time = Time.now.to_f

  (1..ns).each do
    x = x0
    cos_tet = cos_tet0

    while true do
      l = -Math.log(rand) / mu
      x1 = x + l * cos_tet

      if x1 < 0
        backward += 1
        break
      end
      if x1 > h
        forward += 1
        break
      end
      if rand < pa
        stopped += 1
        break
      end

      cos_w = rand ** (1 / (sp + 1))
      sin_fi = Math.sin(2 * Math::PI * rand)
      cos_tet1 = cos_tet * cos_w - Math.sqrt((1 - cos_tet * cos_tet) * (1 - cos_w * cos_w)) * sin_fi
      x = x1
      cos_tet = cos_tet1
    end
  end

  finish_time = Time.now.to_f

  f_ns = forward / ns.to_f
  b_ns = backward / ns.to_f
  s_ns = stopped / ns.to_f

  u_f_ns = Math.sqrt(f_ns * (1 - f_ns) / ns)
  u_b_ns = Math.sqrt(b_ns * (1 - b_ns) / ns)
  u_s_ns = Math.sqrt(s_ns * (1 - s_ns) / ns)

  total_time = (finish_time - start_time)
  average_dispersion = ((f_ns * (1 - f_ns)) + (b_ns * (1 - b_ns)) + (s_ns * (1 - s_ns))) / 3
  laboriousness = average_dispersion * total_time / 3

  { forward: forward, backward: backward, stopped: stopped, f_ns: f_ns, b_ns: b_ns,
    s_ns: s_ns, u_f_ns: u_f_ns, u_b_ns: u_b_ns, u_s_ns: u_s_ns, laboriousness: laboriousness }
end

puts "Modeling of the transfer process of particles in a layer of matter."
puts "\nEnter parameters:"
param_hash = Tools.input_parameters
puts "\nInput parameters:"
param_hash.keys.each { |key| print(" #{key}: #{param_hash.dig(key)}\n") }

res_hash = pas_rad(param_hash)

puts "\nResults of random particle movement."
puts "\nAmount:"
puts "\t1) Forward: #{res_hash.dig(:forward)}"
puts "\t2) Backward: #{res_hash.dig(:backward)}"
puts "\t3) Stopped: #{res_hash.dig(:stopped)}"
puts "\nRatio && Uncertainty:"
puts "\t1) Q_Forward: #{res_hash.dig(:f_ns)}"
puts "\t   Uns_Forward: #{res_hash.dig(:u_f_ns)}"
puts "\t2) Q_Backward: #{res_hash.dig(:b_ns)}"
puts "\t   Uns_Backward: #{res_hash.dig(:u_b_ns)}"
puts "\t3) Q_Stopped: #{res_hash.dig(:s_ns)}"
puts "\t   Uns_Stopped: #{res_hash.dig(:u_s_ns)}"
puts "\nMonte-Carlo laboriousness: #{res_hash.dig(:laboriousness)} seconds"

