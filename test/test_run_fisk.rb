require "helper"
require "fisk/helpers"

class RunFiskTest < Fisk::Test
  def test_negative
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm64(-123)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal(-123, func.call)
  end

  def test_forward_label_rel32
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      jmp label(:foo)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      int lit(3) # crash if we don't jump over this
    put_label :foo
      mov rax, imm32(0x3)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 3, func.call
  end

  def test_label_rel32
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      xor rax, rax
    put_label :loop
      add rax, rdx
      500.times { nop }
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_label_rel8
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      xor rax, rax
    put_label :loop
      add rax, rdx
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_sum
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      xor rax, rax
    put_label :loop
      add rax, rdx
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_jmp
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      jmp label(:foo)
      put_label(:bar)
      mov rax, imm32(100)
      pop rbp
      ret
      put_label(:foo)
      jmp label(:bar)
      mov rax, imm32(42)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_run_fisk
    fisk = Fisk.new
    mem = Fisk::Helpers.mmap_jit 4096

    binary = fisk.asm do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    Fisk::Helpers.memcpy mem, binary.string, binary.string.bytesize
    func = Fiddle::Function.new mem.to_i, [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_jit_memory_has_size
    mem = Fisk::Helpers.mmap_jit 100
    assert_equal 100, mem.size
  end

  def test_get_address
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, rdi
      pop rbp
      ret
    end

    func = jitbuf.to_function [Fiddle::TYPE_VOIDP], Fiddle::TYPE_LONG
    x = Object.new
    wrapped = Fiddle.dlwrap x
    assert_equal wrapped.to_i, func.call(wrapped)
  end

  def test_fisk_jit
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_fisk_get_param
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end
end
