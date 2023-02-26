# frozen_string_literal: true

require 'json'

class JsonManager
  def read
    begin
      json = JSON.parse(File.read('config.json'))
    rescue StandardError => e
      raise "An error occurred while reading file: #{e.message}"
    end

    validate_json(json)
    json
  end

  def write(size, gens)
    table = {
      "size": size,
      "gens": gens
    }
    begin
      File.open('config.json', 'w') do |file|
        file.write(JSON.pretty_generate(table))
      end
      puts "\nConfiguration saved to 'config.json'"
    rescue StandardError => e
      raise "An error occurred while saving file: #{e.message}"
    end
  end

  private

  def validate_json(json)
    raise "Invalid JSON: keys must be 'gens' and 'size'" unless json.keys.sort == %w[gens size]

    raise 'Invalid JSON: values must be integers' unless json.values.all? { |value| value.is_a?(Integer) }

    raise "Invalid JSON: 'size' must be >= 10 and <= 40" unless json['size'] >= 10 && json['size'] <= 40

    raise "Invalid JSON: 'gens' must be >= 10 and <= 100" unless json['gens'] >= 10 && json['gens'] <= 100
  end
end
