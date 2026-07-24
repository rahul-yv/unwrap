enum TrafficLight {
    Red,
    Yellow,
    Green,
}

fn action(light: &TrafficLight) -> &str {
    match light {
        TrafficLight::Red => "stop",
        TrafficLight::Yellow => "slow down",
        TrafficLight::Green => "go",
    }
}

fn main() {
    assert_eq!(action(&TrafficLight::Red), "stop");
    assert_eq!(action(&TrafficLight::Yellow), "slow down");
    assert_eq!(action(&TrafficLight::Green), "go");
    println!("ok");
}
