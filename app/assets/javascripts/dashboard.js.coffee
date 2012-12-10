root = this
$ = root.jQuery

Dashboard = root.Dashboard = root.Dashboard ? {}
utils = Dashboard.utils = {}

$(document).ready ->
  new Dashboard.utils.AutoRefresher()

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
      complete: ->
        $(".refresh_div").removeClass('pulse')
        $(".refresh_div").text("refreshing in " + _this.refresh_time_in_sec + " seconds")
        _this.start_timer()

  update_icps: (icps) ->
    icp_size = $('.icp').size()
    for i in [0..(icp_size-1)] by 1
      @card_html = ''
      @card_html += "<div class='name'>" + icps[i].name + "</div>"
      if icps[i].status == 'good'
        @card_html += "<div class='status-indicator'>&#x2714;</div>"
        $('.icp')[i].setAttribute('class', 'icp card good')
        $('.icp')[i].innerHTML = @card_html
      else
        @card_html += "<div class='status-indicator'>&#x2718;</div>"
        @card_html += "<div class='messages'>"
        for message in icps[i].messages
          @card_html += "<div class='message'>" + message + "</div>"
        @card_html += "</div>"
        $('.icp')[i].setAttribute('class', 'icp card bad')
        $('.icp')[i].innerHTML = @card_html
