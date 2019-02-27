from pydc import HYPE


N_SAMPLES = 500




class World(object):
    def __init__(self, initial_position=0):
        self.position = initial_position
        self.n_left = 0
        self.n_right = 0

    def execute_action(self, best_action):
        if best_action == "action(move(1))":
            self.position += 1
            self.n_right += 1
        elif best_action == "action(move(-1))":
            self.position -= 1
            self.n_left += 1



def main():
    hype = HYPE("example_left_right.pl", N_SAMPLES)
    stop = False

    world = World()
    # while not stop:
    count = 0
    while world.position<6 and count<10:

        # result = hype.plan_step("[]".format(world.position), N_SAMPLES, max_horizon=10, used_horizon=5, use_abstraction=False)
        result = hype.plan_step("[observation(position_obs)~={}]".format(world.position), N_SAMPLES, max_horizon=10, used_horizon=5, use_abstraction=False)
        print(result)

        best_action = result["best_action"]
        stop = result["stop"]

        world.execute_action(best_action)

        count +=1


    print("Final position: {}".format(world.position))
    print("Left movements: {}".format(world.n_left))
    print("Right movements: {}".format(world.n_right))


if __name__ == "__main__":
    main()
