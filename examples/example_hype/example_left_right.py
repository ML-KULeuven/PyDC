from pydc import HYPE


N_SAMPLES = 500

def main():
    hype = HYPE("example_left_right.pl", N_SAMPLES)
    stop = False
    position = 0
    while not stop:
        result = hype.plan_step("[]", N_SAMPLES, max_horizon=10, used_horizon=5, use_abstraction=False)
        # result = hype.plan_step("[observation(pos)~={}]".format(position), N_SAMPLES, max_horizon=10, used_horizon=5, use_abstraction=False)

        print(result)
        if result["best_action"] == "action(move(right))":
            position += 1
        elif result["best_action"] == "action(move(left))":
            position -= 1

        stop = result["stop"]
        stop=True #delete once it works


    print("Final position: {}".format(position))



if __name__ == "__main__":
    main()
