# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERDPS
    forms = []
    operands = []
    encodings = []
    # vgatherdps: xmm{k}, vm32x
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdps: ymm{k}, vm32y
    operands << OPERAND_TYPES[85]
    operands << OPERAND_TYPES[87]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdps: zmm{k}, vm32z
    operands << OPERAND_TYPES[86]
    operands << OPERAND_TYPES[88]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdps: xmm, vm32x, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdps: ymm, vm32y, ymm
    operands << OPERAND_TYPES[82]
    operands << OPERAND_TYPES[87]
    operands << OPERAND_TYPES[82]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VGATHERDPS = Instruction.new("VGATHERDPS", forms)
  end
end
