root = this
$ = root.jQuery

Dashboard = root.Dashboard = root.Dashboard ? {}
utils = Dashboard.utils = {}

$(document).ready ->
  new Dashboard.utils.AutoRefresher()
  @clock = setInterval(clock_count, 1000)

clock_count = ->
  @time = new Date()
  @st = @time.toString()
  $('.clock').html(@st)

class utils.AutoRefresher
  constructor: ->
    @$icps = $(".icps")
    @$timer = $("#timer")
    @refresh_time_in_sec = 10
    @refresh_interval
    @start_timer()

  start_timer: =>
    @refresh_interval = setInterval(@countdown, 1000)

  countdown: =>
    if @refresh_time_in_sec > 1
      @refresh_time_in_sec -= 1
      if @refresh_time_in_sec == 1
        $(".refresh_div").text("refreshing in " +
          @refresh_time_in_sec + " second...")
      else
        $(".refresh_div").text("refreshing in " +
          @refresh_time_in_sec + " seconds...")

    else
      @refresh_time_in_sec = 10
      clearInterval(@refresh_interval)
      @update_data()


  update_data: =>
    _this = this

    $.ajax
      beforeSend: ->
        $(".refresh_div").text('refeshing')
        $(".refresh_div").addClass('pulse')
      dataType: "json"
      url: "/dashboard"
      success: (data) ->
        _this.update_icps(data["all_icps"])
        _this.update_ci_projects(data["all_ci_projects"])
      complete: ->
        $(".refresh_div").removeClass('pulse')
        $(".refresh_div").text("refreshing in " + _this.refresh_time_in_sec + " seconds")
        _this.start_timer()

  update_icps: (icps) ->
    @cards_html = "<div class='header'>Icps</div> "
    for icp in icps
      if icp.status == 'bad'
        @cards_html += "<div class='icp card bad'> "
        @cards_html += "<div class='name'>" + icp.name + "</div> "
        @cards_html += "<div class='status-indicator'>&#x2718;</div> "
        @cards_html += "<div class='messages'> "
        for message in icp.messages
          @cards_html += "<div class='message'>" + message + "</div> "
        @cards_html += "</div></div> "
    @cards_html += "<div class='divider'></div> "
    for icp in icps
      if icp.status == 'good'
        @cards_html += "<div class='icp card good'> "
        @cards_html += "<div class='name'>" + icp.name + "</div> "
        @cards_html += "<div class='status-indicator'>&#x2714;</div> "
        @cards_html += "</div> "
    $('.icps').html(@cards_html)

  update_ci_projects: (ci_projects) ->
    @cards_html = "<div class='header'>Jenkins Projects</div> "
    for project in ci_projects
      if project.last_build_result == 'bad'
        @cards_html += "<div class='jenkins card bad'> "
        @cards_html += "<div class='name'>"
        @cards_html += "<a target='_blank' href='"+ project.last_build_url +
          "'>" + project.name + "</a>"
        @cards_html += "</div>"
        @cards_html += "<div class='status-indicator'>&#x2718;</div> "
        @cards_html += "</div> "
    @cards_html += "<div class='divider'></div> "
    for project in ci_projects
      if project.last_build_result == 'good'
        @cards_html += "<div class='jenkins card good'> "
        @cards_html += "<div class='name'>"
        @cards_html += "<a target='_blank' href='"+ project.last_build_url +
          "'>" + project.name + "</a>"
        @cards_html += "</div>"
        @cards_html += "<div class='status-indicator'>&#x2714;</div> "
        @cards_html += "</div> "
    $('.ci-projects').html(@cards_html)
