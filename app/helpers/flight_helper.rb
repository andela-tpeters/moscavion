module FlightHelper
  def format_date(date)
    date.localtime.strftime("%d, %B %Y @ %H:%M:%S")
  end

  def flight_row(description, icon_name, value)
    """
    <tr>
      <td>#{icon(icon_name)} #{description}</td>
      <td>#{value}</td>
    </tr>
    """.html_safe
  end

  def icon(name, color = "brown")
    "<i class='#{name} #{color} icon'></i>".html_safe
  end
end
