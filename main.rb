require 'ruby2d'

# Window
set title: 'Window'
@width = 640
@height = 480
set width: @width, height: @height

@gravity = 0.9
@velocity = [1, 0]
@friction = 100
@airDrag = 1

@obj = Circle.new(x: 100, y: 100, radius: 50, color: 'red')

def clamp(value, min, max)
  [min, [value, max].min].max
end

# apply physics to the circles and create collisions between circles
def collisions(obj)
    left = 0
    right = 0
    top = 0
    bottom = 0
    if obj.x - obj.radius < 0
        left = 1
    end
    # Checks for collisions with the right side of the screen
    if obj.x + obj.radius > @width
        right = 1
    end
    # Checks for collisions with the top of the screen
    if obj.y - obj.radius < 0
        top = 1
    end
    # Checks for collisions with the bottom of the screen
    if obj.y + obj.radius > @height
        bottom = 1
    end
    return [left, right, top, bottom]
end
def draw()  
    # Collision checking
    left, right, top, bottom = collisions(@obj)

    # Collision checks and Velocity adjustments
    if bottom == 1
        @velocity[0] = 0
        @velocity = @velocity[1] / @friction
    end
    if bottom == 0
        @velocity[0] *= @airDrag
        @velocity[1] *= @airDrag
        @velocity[1] += @gravity
    end
    # add velocity to the position
    @obj.x += @velocity[0]
    @obj.y += @velocity[1]
    # Clamp the position of the circle
    @obj.x = clamp(@obj.x, 0, @width - @obj.radius)
    @obj.y = clamp(@obj.y, 0, @height - @obj.radius)
end

on :key_down do |event|
    if event.key == 'space'
        @velocity[1] = -20
    elsif event.key == 'w'
        @velocity[1] = -20
    elsif event.key == 'a'
        @velocity[0] = -5
    elsif event.key == 'd'
        @velocity[0] = 5
    end
  end

update do
    draw()
end

show