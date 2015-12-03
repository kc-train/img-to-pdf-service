class PowerPoint
  constructor: (@$elm)->
    @bind_event()

  bind_event: ->
    @$elm.on "click", "button.submit", (evt)=>
      title = jQuery(event.target).closest(".image-form").find("input.title").val()
      image_path = jQuery(event.target).closest(".image-form").find("input.image-path").val()
      jQuery.ajax
        method: "POST"
        url: "/images"
        data:
          "image[title]": title,
          "image[url]": image_path


jQuery(document).on 'page:change', ->
  if jQuery(".page-home-index").length > 0
    new PowerPoint(jQuery(".page-home-index"))