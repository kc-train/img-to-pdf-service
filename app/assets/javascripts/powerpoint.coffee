class PowerPoint
  constructor: (@$elm)->
    @bind_event()

  bind_event: ->
    @$elm.on "click", ".create-ppt", (evt)=>
      jQuery.ajax
        method: "GET"
        url: "/home/create_ppt"
        success: ()=>
          @$elm.find(".image-form").toggleClass "hidden"

      @$elm.on "click", "button.submit", (evt)=>
        title = jQuery(event.target).closest(".image-form").find("input.title").val()
        image_path = jQuery(event.target).closest(".image-form").find("input.image-path").val()
        jQuery.ajax
          method: "GET"
          url: "/home/add_image"
          data:
            "title": title,
            "image_path": image_path
          success: ()=>
            @$elm.find(".image-form").toggleClass "hidden"

jQuery(document).on 'page:change', ->
  if jQuery(".page-home-index").length > 0
    new PowerPoint(jQuery(".page-home-index"))