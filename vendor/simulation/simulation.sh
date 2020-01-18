#! /bin/bash

counter=1
until [ $counter -gt 100 ]
do
  echo 'simulation ' $counter
  name="simulations/simulation_$counter.txt"
  rspec spec/plot_spec.rb:169 >> $name
  ((counter++))
done

echo All done