MoreViewHooks.instance_eval do
  add(:view_projects_contextual,
      virtual_path: "projects/show",
      insert_top:   "div.contextual"
  )

  add(:view_projects_show_top,
      virtual_path:  "projects/show",
      insert_before: "div.splitcontentleft"
  )

  add(:view_projects_show_bottom,
      virtual_path: "projects/show",
      insert_after: "div.splitcontentright"
  )

  add(:view_projects_show_sidebar_top,
      virtual_path:  "projects/_sidebar",
      insert_before: "erb[silent]:contains('if @total_hours.present?')"
  )
end
