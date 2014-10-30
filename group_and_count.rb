module GroupAndCount
  def self.group_and_count(rows, *keys, **opts)
    keys.flatten!

    result = rows.group_by { |row| row[keys.first] }

    # some rows don't have the key, so we get rid of them here
    result.delete(nil)

    if keys.length == 1
      result.each do |k, rows|
        result[k] = rows.length
      end
    else
      keys.shift
      result.each do |k, rows|
        result[k] = group_and_count(rows, *keys, **opts)
      end
    end

    result
  end
end