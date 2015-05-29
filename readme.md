## mbed HAL

This module defines the API for the mbed low-level Hardware Abstraction Layer,
which is implemented by target-specific modules.

### Installation
```
yotta install --save ARMmbed/mbed-hal
```

### Usage
TBC


### API
TBC

### Porting
mbed-hal requires a number of sub-modules when a port is created.  The expected hierarchy is:
```
               +----------+
               | mbed-hal |
               +----+-----+
                    | TD
           +--------+----------+
           | mbed-hal-<vendor> |
           +--------+----------+
                    | TD
   +----------------+----------------+   D   +--------------------------------+
   | mbed-hal-<vendor>-<chip family> +-------+ mbed-hal-<vendor>-<vendor hal> |
   +----------------+----------------+       +--------------------------------+
                    | TD
       +------------+-------------+
       | mbed-hal-<vendor>-<chip> |
       +--------------------------+
```

In the diagram above, five hal repos are defined to support a single target.  Each of these repos should contain specific parts of the mbed hal.

#### mbed-hal-\<vendor\>
This repo contains redirections based on target only.  mbed-hal-<vendor> should contain a single file: a module.json.
Contains:
Dependencies: None
Target Dependencies: mbed-hal-\<vendor\>-\<chip family\>

#### mbed-hal-\<vendor\>-\<chip family\>
This repo should contain the files which implement the api defined in mbed-hal, e.g. spi_api.c, uart_api.c, us_ticker.c, etc.
Contains:
* source
  * analogin_api.c
  * analogout_api.c
  * gpio_api.c
  * gpio_irq_api.c
  * i2c_api.c
  * lp_ticker.c
  * pinmap.c
  * port_api.c
  * pwmout_api.c
  * rtc_api.c
  * serial_api.c
  * sleep.c
  * spi_api.c
  * us_ticker.c
* mbed-hal-\<vendor\>-\<chip family\>
  * PeripheralPins.h
  * PortNames.h
  * gpio_object.h
  * objects.h

Dependencies: mbed-hal-\<vendor\>-\<vendor hal\>
Target Dependencies: mbed-hal-\<vendor\>-\<chip\>

#### mbed-hal-\<vendor\>-\<vendor hal\>
Contains a vendor-specific hal if necessary.  This repo is optional.  No dependencies are mandated, but most implementations of this repo will include a dependency on mbed-hal-\<vendor\>-\<chip family\>
Contains: Vendor-specific HAL
Dependencies: None required
Target Dependencies: None required

#### mbed-hal-\<vendor\>-\<chip\>
The chip-specific definitions expected by the vendor HAL and/or mbed-hal-\<vendor\>-\<chip family\>

Contains: chip-specific definitions and code
Dependencies: None required
Target Dependencies: None required
