/**
* super simple carousel
* animation between panes happens with css transitions
*/
function Carousel(element)
{
    'use strict';
    var self = this;
    element = $(element);

    var container = $(">ul", element),
        panes = $(">ul>li", element),
        $w = $(window),
        $popup = $('.popup'),
        $button = $('a.button'),

        pane_width = 0,
        pane_count = panes.length,

        current_pane = 0;

    /**
     * initial
     */
    this.init = function() {
        setPaneDimensions();
        setCurrent();

        $(window).on("load resize orientationchange", function() {
            setPaneDimensions();
        })
    };

    this.refresh = function() {
        current_pane = 0;
        panes = $(">ul>li", element);
        pane_count = panes.length;

        setPaneDimensions();
        setCurrent();
    };

    function setCurrent() {
        $(panes).removeClass('current');
        $(panes[current_pane]).addClass('current');
    };

    /**
     * set the pane dimensions and scale the container
     */
    function setPaneDimensions() {
        pane_width = element.width();
        panes.each(function() {
            $(this).width(pane_width);
        });
        container.width(pane_width*pane_count);
    };


    /**
     * show pane by index
     */
    this.showPane = function(index, animate) {
        // between the bounds
        index = Math.max(0, Math.min(index, pane_count-1));
        current_pane = index;

        var offset = -((100/pane_count)*current_pane);
        setContainerOffset(offset, animate);

        $(panes).removeClass('current');
        $(panes[current_pane]).addClass('current');

        var currentHeight = $('.current').height();
        container.height(currentHeight);
    };


    function setContainerOffset(percent, animate) {
        container.removeClass("animate");

        if(animate) {
            container.addClass("animate");
        }

        if(Modernizr.csstransforms3d) {
            container.css("transform", "translate3d("+ percent +"%,0,0) scale3d(1,1,1)");
        }
        else if(Modernizr.csstransforms) {
            container.css("transform", "translate("+ percent +"%,0)");
        }
        else {
            var px = ((pane_width*pane_count) / 100) * percent;
            container.css("left", px+"px");
        }
    }

    this.next = function() { return this.showPane(current_pane+1, true); };
    this.prev = function() { return this.showPane(current_pane-1, true); };

    function handleHammer(ev) {
        // disable browser scrolling
        ev.gesture.preventDefault();



        switch(ev.type) {
            case 'dragright':
            case 'dragleft':
                // stick to the finger
                var pane_offset = -(100/pane_count)*current_pane;
                var drag_offset = ((100/pane_width)*ev.gesture.deltaX) / pane_count;

                // slow down at the first and last pane
                if((current_pane == 0 && ev.gesture.direction == "right") ||
                    (current_pane == pane_count-1 && ev.gesture.direction == "left")) {
                    drag_offset *= .4;
                }

                setContainerOffset(drag_offset + pane_offset);
                break;

            case 'swipeleft':
                self.next();
                ev.gesture.stopDetect();
                break;

            case 'swiperight':
                self.prev();
                ev.gesture.stopDetect();
                break;

            case 'release':
                // more then 50% moved, navigate
                if(Math.abs(ev.gesture.deltaX) > pane_width/2) {
                    if(ev.gesture.direction == 'right') {
                        self.prev();
                    } else {
                        self.next();
                    }
                }
                else {
                    self.showPane(current_pane, true);
                }
                break;
        }
    }

    new Hammer(element[0], { behavior: { userSelect: true, userDrag: "none" }, dragLockToAxis: true }).on("tap release dragleft dragright swipeleft swiperight", handleHammer);

    $w.resize(function() {
        setTimeout(function() {
            var currentHeight = $('.current').height();
            container.height(currentHeight);
        }, 300);
    });

    $w.trigger("resize");

    $button.on("click", function(e) {
        e.preventDefault();
        $popup.addClass("opened");
    });

    $button.on("tap", function(e) {
        e.preventDefault();
        $popup.addClass("opened");
    });
}
