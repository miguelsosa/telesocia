module TelesocisHelper

  # TODO: consider if we should make nickname a required field
  # helper to ensure that nickname has *something* on it.
  def get_nickname(telesoci)
    telesoci.nickname || 'unknown'
  end

  def display_name(telesoci)
    cap_ln = telesoci.last_name.try(:capitalize)
    cap_fn = telesoci.first_name.try(:capitalize)
    cap_ln && cap_fn ? "#{cap_ln}, #{cap_fn}" : cap_ln || cap_fn || nil
  end

end
