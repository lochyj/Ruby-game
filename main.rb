require 'ruby2d'

# Window
set title: 'Window'
@width = 640
@height = 480
set width: @width, height: @height

@gravity = 0.9
@velocity = [0, 0]
@friction = 0.1
@airDrag = 1

@obj = Circle.new(x: 100, y: 100, radius: 50, color: 'red')
@obj2 = Circle.new(x: 250, y: 100, radius: 50, color: 'blue')

def clamp(value, min, max)
    [min, [value, max].min].max
end

# apply physics to the circles and create collisions between circles
def collisions(obj)
    left = false
    right = false
    top = false
    bottom = false
    if obj.x - obj.radius < 0
        left = true
    end
    # Checks for collisions with the right side of the screen
    if obj.x + obj.radius > @width
        right = true
    end
    # Checks for collisions with the top of the screen
    if obj.y - obj.radius < 0
        top = true
    end
    # Checks for collisions with the bottom of the screen
    if obj.y + obj.radius > @height
        bottom = true
    end
    return [left, right, top, bottom]
end
def draw(obj)  
    col = {
        left: false,
        top: false,
        bottom: false,
        right: false
    }
    state = {
        grounded: false,
        jumping: false,
        walking: false,
        running: false
    }
    # Collision checking
    col.left, col.right, col.top, col.bottom = collisions(obj)
    left = col.left
    right = col.right
    top = col.top
    bottom = col.bottom
    if col.left == true
        grounded = true
    end

    # Collision checks and Velocity adjustments
    if bottom == 1
        @velocity[1] = 0
        obj.y = @height - obj.radius
    end
    if bottom == 0
        @velocity[0] *= @airDrag
        @velocity[1] *= @airDrag
        @velocity[1] += @gravity
    end
    if left == 1
        @velocity[0] = 0
        obj.x = obj.radius
    end
    if right == 1
        @velocity[0] = 0
        obj.x = @width -  obj.radius
    end
    if top == 1
        @velocity[1] = 0
        obj.y = obj.radius
    end

    # State management
    # add velocity to the position
    obj.x += @velocity[0]
    obj.y *= @velocity[1]
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
    elsif event.key == 's'
        @velocity[1] = 0
        @velocity[0] = 0
    end
  end

update do
    draw(@obj)
    draw(@obj2)
    
end

show