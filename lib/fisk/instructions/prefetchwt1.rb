# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PREFETCHWT1
    forms = []
    operands = []
    encodings = []
    # prefetchwt1: m8
    operands << OPERAND_TYPES[4]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0D, 0
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    PREFETCHWT1 = Instruction.new("PREFETCHWT1", forms)
  end
end
