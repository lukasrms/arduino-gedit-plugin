mkdir "{!temp-build-dir}"
rm -f "{!sketch-path}.log"
touch "{!temp-build-dir}/{!sketch-name}.cpp"
cat /usr/lib/gedit-2/plugins/arduino/before >> "{!temp-build-dir}/{!sketch-name}.cpp"
cat "{!sketch-path}"  >> "{!temp-build-dir}/{!sketch-name}.cpp"
cat /usr/lib/gedit-2/plugins/arduino/after >> "{!temp-build-dir}/{!sketch-name}.cpp"
cat "{!temp-build-dir}/{!sketch-name}.cpp"
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/wiring_digital.c -o{!temp-build-dir}/wiring_digital.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/wiring_shift.c -o{!temp-build-dir}/wiring_shift.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/pins_arduino.c -o{!temp-build-dir}/pins_arduino.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/wiring_analog.c -o{!temp-build-dir}/wiring_analog.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/wiring.c -o{!temp-build-dir}/wiring.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/wiring_pulse.c -o{!temp-build-dir}/wiring_pulse.c.o 
avr-gcc -c -g -Os -w -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/WInterrupts.c -o{!temp-build-dir}/WInterrupts.c.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/Tone.cpp -o{!temp-build-dir}/Tone.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/WMath.cpp -o{!temp-build-dir}/WMath.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/WString.cpp -o{!temp-build-dir}/WString.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/HardwareSerial.cpp -o{!temp-build-dir}/HardwareSerial.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/main.cpp -o{!temp-build-dir}/main.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} {!libs-dir}/Print.cpp -o{!temp-build-dir}/Print.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/wiring_digital.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/wiring_shift.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/pins_arduino.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/wiring_analog.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/wiring.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/wiring_pulse.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/WInterrupts.c.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/Tone.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/WMath.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/WString.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/HardwareSerial.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/main.cpp.o 
avr-ar rcs {!temp-build-dir}/core.a {!temp-build-dir}/Print.cpp.o 
avr-g++ -c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections {!cpu-full} -I{!libs-dir} "{!temp-build-dir}/{!sketch-name}.cpp" -o "{!temp-build-dir}/{!sketch-name}.cpp.o"  2> {!sketch-path}.log
avr-gcc -Os -Wl,--gc-sections {!cpu} -o "{!temp-build-dir}/{!sketch-name}.cpp.elf" "{!temp-build-dir}/{!sketch-name}.cpp.o" {!temp-build-dir}/core.a -L{!temp-build-dir} -lm 
avr-objcopy -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0 "{!temp-build-dir}/{!sketch-name}.cpp.elf" "{!temp-build-dir}/{!sketch-name}.cpp.eep" 
avr-objcopy -O ihex -R .eeprom "{!temp-build-dir}/{!sketch-name}.cpp.elf" "{!temp-build-dir}/{!sketch-name}.cpp.hex"
rm -f "{!sketch-path}.hex.old"
mv "{!sketch-path}.hex" "{!sketch-path}.hex.old"
rm -f {!sketch-path}.hex
cp "{!temp-build-dir}/{!sketch-name}.cpp.hex" "{!sketch-path}.hex"
rm -f -rf {!temp-build-dir}
