# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sixsoon2::Application.initialize!
Haml::Template::options[:ugly] = false
require "will_paginate"
WillPaginate::ViewHelpers.pagination_options[:prev_label]=I18n.t("pagination.prev")
WillPaginate::ViewHelpers.pagination_options[:next_label]=I18n.t("pagination.next")

