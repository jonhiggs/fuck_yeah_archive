module FuckYeahArchive
  class Document
    def initialize(source)
      @markdown = File.read(source)
    end

    def heading
      @markdown.each_line do |l|
        return l.gsub(/^#\ /, '').strip if l.match(/^#/)
      end
    end

    def source
      @markdown.each_line do |l|
        if l.match(/^\[Source\]/)
          l.gsub!(/^\[Source\]\(/, '')
          return l.split.first
        end
      end
    end

    def refs
      refs = {}
      @markdown.each_line do |l|
        next unless l.match(/^\[\d\]:\ /)
        k,v = l.split
        k.gsub!(/[^0-9]/, '')
        refs[k.to_i] = v
      end
      refs
    end

    def image_refs
      ids = image_ref_ids
      refs.delete_if { |k,v| !ids.include?(k) }
    end

    def image_ref_ids
      ids = []

      @markdown.each_line do |l|
        next unless l.match /!\[.*\]\[.*\]/
        ids.push(l.match(/!\[.*\]\[([0-9]+)\]/)[1].to_i)
      end
      ids.sort.uniq
    end
  end
end
