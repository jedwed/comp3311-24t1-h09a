create or replace function add_state(curr_state numeric, curr_value numeric) returns numeric 
as $$
begin
    return curr_state + curr_value;
end
$$ language plpgsql;

create aggregate my_sum ( numeric ) (
    sfunc = add_state,
    stype = numeric,
    initcond = 0
)

create type StateType as (curr_sum numeric, curr_count numeric);

create or replace function update_average_state(curr_state StateType, curr_value numeric) returns StateType
as $$
declare
    next_state StateType;
begin
    if curr_value is not null then 
        curr_state.curr_sum := curr_state.curr_sum + curr_value; 
        curr_state.curr_count := curr_state.curr_count + 1;
    end if;
    return curr_state;
end
$$ language plpgsql;

create or replace function compute_average(state StateType) returns numeric
as $$
begin
    if state.curr_count = 0 then
        return null;
    end if;
    return (state.curr_sum / state.curr_count);
end
$$ language plpgsql;

create aggregate my_average ( numeric ) (
    sfunc = update_average_state,
    stype = StateType,
    initcond = '(0,0)',
    finalfunc = compute_average
)
