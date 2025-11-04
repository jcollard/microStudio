Students have just completed the @CollisionChallenge.html and they need to apply what they have learned to their Space Game to make their lasers collide with their enemy objects.

The code that will be used for the lesson / tutorial is here @colliding-lasers/starter.lua but, they should first implement it using this code which they can clone from here:  https://microstudio.dev/i/jocolloman/addingcollisiondetection/

Then, if they would like, they can update their existing projects to use the changes.

The lesson plan should utilize the collision detection code they wrote in the collision detection challenge. More specifically they should be able to take the boxes_colliding function from @colliding-lasers/finished-collision.lua  and add it to their project.

Here are the steps I would like students to take:

1. Clone the starter project

Next, to be able to use the boxes_colliding function, they need to ensure that all of the objects that can be collided with have a box defined for them. The next step is to update their googly eyes to have a bounding box that can be seen. In the step three, they must refactor their code so eyes are now defined as boxes. 

Student should add the create_boxes function from the collision detection challenge

-- Function to create a new box
function create_box(x, y, size, vx, vy, color)
  local new_box = {
    x = x,
    y = y,
    size = size,
    vx = vx,
    vy = vy,
    color = color,
    original_color = color
  }
  return new_box
end

Then, they should update their init_eyes method to use it instead of all the variables that are currently there. 
Give the code for creating a box for one eye, but the student must create a box for the second eye.

Doing this will cause run time errors because they have replaced their existing code. They need to update their code in update_eyes and draw_eyes to use the new definition for eye.

Finally, update draw_eyes to draw a rectangle around the eye sprite.

We will add more to the lesson once we have finished writing this part.