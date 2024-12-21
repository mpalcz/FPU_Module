library verilog;
use verilog.vl_types.all;
entity Multiplier is
    port(
        Overflow        : out    vl_logic;
        L23             : in     vl_logic;
        L22             : in     vl_logic;
        L21             : in     vl_logic;
        L20             : in     vl_logic;
        L19             : in     vl_logic;
        L18             : in     vl_logic;
        L17             : in     vl_logic;
        L16             : in     vl_logic;
        L15             : in     vl_logic;
        L14             : in     vl_logic;
        L13             : in     vl_logic;
        L12             : in     vl_logic;
        L11             : in     vl_logic;
        L10             : in     vl_logic;
        L9              : in     vl_logic;
        L8              : in     vl_logic;
        L7              : in     vl_logic;
        L6              : in     vl_logic;
        L5              : in     vl_logic;
        L4              : in     vl_logic;
        L3              : in     vl_logic;
        L2              : in     vl_logic;
        L1              : in     vl_logic;
        L0              : in     vl_logic;
        Sel             : in     vl_logic;
        Clk             : in     vl_logic;
        En              : in     vl_logic;
        Multiplicand23  : in     vl_logic;
        Multiplicand22  : in     vl_logic;
        Multiplicand21  : in     vl_logic;
        Multiplicand20  : in     vl_logic;
        Multiplicand19  : in     vl_logic;
        Multiplicand18  : in     vl_logic;
        Multiplicand17  : in     vl_logic;
        Multiplicand16  : in     vl_logic;
        Multiplicand15  : in     vl_logic;
        Multiplicand14  : in     vl_logic;
        Multiplicand13  : in     vl_logic;
        Multiplicand12  : in     vl_logic;
        Multiplicand11  : in     vl_logic;
        Multiplicand10  : in     vl_logic;
        Multiplicand9   : in     vl_logic;
        Multiplicand8   : in     vl_logic;
        Multiplicand7   : in     vl_logic;
        Multiplicand6   : in     vl_logic;
        Multiplicand5   : in     vl_logic;
        Multiplicand4   : in     vl_logic;
        Multiplicand3   : in     vl_logic;
        Multiplicand2   : in     vl_logic;
        Multiplicand1   : in     vl_logic;
        Multiplicand0   : in     vl_logic;
        prod47          : out    vl_logic;
        prod46          : out    vl_logic;
        prod45          : out    vl_logic;
        prod44          : out    vl_logic;
        prod43          : out    vl_logic;
        prod42          : out    vl_logic;
        prod41          : out    vl_logic;
        prod40          : out    vl_logic;
        prod39          : out    vl_logic;
        prod38          : out    vl_logic;
        prod37          : out    vl_logic;
        prod36          : out    vl_logic;
        prod35          : out    vl_logic;
        prod34          : out    vl_logic;
        prod33          : out    vl_logic;
        prod32          : out    vl_logic;
        prod31          : out    vl_logic;
        prod30          : out    vl_logic;
        prod29          : out    vl_logic;
        prod28          : out    vl_logic;
        prod27          : out    vl_logic;
        prod26          : out    vl_logic;
        prod25          : out    vl_logic;
        prod24          : out    vl_logic;
        prod23          : out    vl_logic;
        prod22          : out    vl_logic;
        prod21          : out    vl_logic;
        prod20          : out    vl_logic;
        prod19          : out    vl_logic;
        prod18          : out    vl_logic;
        prod17          : out    vl_logic;
        prod16          : out    vl_logic;
        prod15          : out    vl_logic;
        prod14          : out    vl_logic;
        prod13          : out    vl_logic;
        prod12          : out    vl_logic;
        prod11          : out    vl_logic;
        prod10          : out    vl_logic;
        prod9           : out    vl_logic;
        prod8           : out    vl_logic;
        prod7           : out    vl_logic;
        prod6           : out    vl_logic;
        prod5           : out    vl_logic;
        prod4           : out    vl_logic;
        prod3           : out    vl_logic;
        prod2           : out    vl_logic;
        prod1           : out    vl_logic;
        prod0           : out    vl_logic;
        mux0            : out    vl_logic;
        mux1            : out    vl_logic;
        mux2            : out    vl_logic;
        mux3            : out    vl_logic;
        mux4            : out    vl_logic;
        mux5            : out    vl_logic;
        mux6            : out    vl_logic;
        mux7            : out    vl_logic;
        bit_out         : out    vl_logic
    );
end Multiplier;
