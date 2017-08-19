# Important
Before building, Altera tools must be initialized.

```zsh
source init_aoc_esa.sh
```

# Compile host

Executable "host" in put under ./bin

```zsh
make clean
make
```

# Compile kernel for emulation

Kernels are implemented in different .cl files
But are included in calc_initpop.cl

```zsh
aoc -march=emulator -v --board s5_ref ./device/calc_initpop.cl  -o bin/docking.aocx
```

```zsh
aoc -march=emulator -Werror -v --board a10gx device/Krnl_GA.cl -o bin/docking.aocx -DEMULATOR
```

# Relaxed fp operations

```zsh
aoc -march=emulator --fp-relaxed --fpc -v --board a10gx device/Krnl_GA.cl -o bin/docking.aocx
```

# Run ofdock (under ./bin)

Emulation: this will execute 1 run

```zsh
env CL_CONTEXT_EMULATOR_DEVICE_ALTERA=1 ./host -ffile ../input_data/1hvr_vegl.maps.fld -lfile ../input_data/1hvrl.pdbqt
```

```zsh
env CL_CONTEXT_EMULATOR_DEVICE_ALTERA=1 ./host -ffile ../input_data/3ptb/derived/3ptb_protein.maps.fld -lfile ../input_data/3ptb/deri$
```

# FPGA: this will execute 1 run

```zsh
./host -ffile ../input_data/1hvr_vegl.maps.fld -lfile ../input_data/1hvrl.pdbqt -nrun 1
```
