module Tools

  def input_parameters

    tet0 = 45
    cos_tet0 = Math.cos(Math::PI * tet0.to_f / 180)
    h = 2.0
    mu = 1.0
    pa = 0.001
    sp = 1.0
    ns = 10000
=begin
    tet0 = h = mu = pa = sp = ns = ""
    cos_tet0 = 0


    begin
      while true do
        if tet0.empty?
          puts("Angle of incidence (tet0)\n(from 0\u00B0 to 360\u00B0):")
          tet0 = STDIN.gets.chomp
          tmp = Float(tet0)
          unless tmp > 0 and tmp < 360
            tet0 = ""
            puts "\e[31mError: angle of incidence must be from 0 to 180.\e[0m"
            next
          end
          cos_tet0 = Math.cos(Math::PI * tet0.to_f / 180)
        elsif h.empty?
          puts("Layer thickness (h): ")
          h = STDIN.gets.chomp
          tmp = Float(h)
          unless tmp > 0
            h = ""
            puts "\e[31mError: layer thickness must be positive value.\e[0m"
          end
        elsif mu.empty?
          puts("Characteristic of the interaction of a particle with a substance (mu)\n(from 0 to 1):")
          mu = STDIN.gets.chomp
          tmp = Float(mu)
          unless tmp >= 0 and tmp <= 1
            mu = ""
            puts "\e[31mError: absorption probability must be from 0 to 1.\e[0m"
          end
        elsif pa.empty?
          puts("Absorption probability (pa)\n(from 0 to 1):")
          pa = STDIN.gets.chomp
          tmp = Float(pa)
          unless tmp >= 0 and tmp <= 1
            pa = ""
            puts "\e[31mError: absorption probability must be from 0 to 1.\e[0m"
          end
        elsif sp.empty?
          puts("Scatter parameter (sp):")
          sp = STDIN.gets.chomp
          tmp = Integer(sp)
          unless tmp >= 1
            sp = ""
            puts "\e[31mError: scatter parameter must be more than 1.\e[0m"
          end
        elsif ns.empty?
          puts("Statistics (ns): ")
          ns = STDIN.gets.chomp
          tmp = Integer(ns)
          unless tmp > 0
            ns = ""
            puts "\e[31mError: statistics must be positive value.\e[0m"
          end
        else
          break
        end
      end
    rescue ArgumentError
      puts "\e[31mError: Non-numeric used.\e[0m"
      exit(-1)
    end
=end

    { tet0: tet0.to_f, cos_tet0: cos_tet0, h: h.to_f, mu: mu.to_f, l_av: (1 / mu.to_f), pa: pa.to_f, sp: sp.to_f, ns: ns.to_i }
  end
end
