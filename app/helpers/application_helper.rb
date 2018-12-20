module ApplicationHelper

  def current_user_authorized_for_brand?
    user_signed_in? &&
    current_tenant &&
    current_tenant.account.users.include?(current_user) ||
    (current_user && current_user.account.brands.exists? && current_user.account.brands.include?(current_tenant) )
  end

  def date_display(date, time = true)
    if date.present?
      arg = time ? '%B %e, %Y @ %-l:%M%P' : '%B %e, %Y'
      date.strftime(arg)
    end
  end

  def time_display(date)
    date.strftime('%-I:%M%P') if date.present?
  end

  def ordinalize_time(time)
    time.strftime("%a, %b #{time.day.ordinalize} @ %-I:%M%P") if time.present?
  end

  def ordinalize_time_no_time(time)
    time.strftime("%b #{time.day.ordinalize} %Y") if time.present?
  end

  def title(*page_title)
    if Array(page_title).size.zero?
      content_for?(:title) ? content_for(:title) : t(:site_title)
    else
      content_for :title, (Array(page_title) << t(:site_title)).join(' - ')
    end
  end

  def status_label(status)
    if status.present?
      case status
      when 'active', 'processed'
        label = 'success'
      when 'errored', 'canceled','past_due'
        label = 'danger'
      when 'pending','unpaid'
        label = 'warning'
      end
      content_tag :span, class:"badge badge-#{label}" do
        status
      end
    end
  end

end
