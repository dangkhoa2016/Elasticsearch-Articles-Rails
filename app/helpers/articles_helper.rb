module ArticlesHelper
    def badge_categories(categories)
        return unless categories.present?

        categories.in_groups_of(badge_colors.size, false).map do |group|
            group.each_with_index.map do |category, index|
                link_to("<span class='badge badge-#{badge_colors[index]}'>#{category.title}</span>".html_safe, category_path(category.id), class: 'h4')
            end
        end.flatten.join(', ')
    end

    def badge_colors
        @badge_colors ||= %w(Primary Secondary Success Danger Warning Info Light Dark).map(&:downcase)
    end
end
