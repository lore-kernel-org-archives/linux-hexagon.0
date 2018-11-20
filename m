From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v2 00/15] Prepare for PTRACE_GET_SYSCALL_INFO
Date: Tue, 20 Nov 2018 03:11:29 +0300
Message-ID: <20181120001128.GA11300@altlinux.org>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Albert Ou <aou@eecs.berkeley.edu>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Chris Zankel <chris@zankel.net>, Eric Paris <eparis@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Moore <paul@paul-moore.com>, Richard Kuo <rkuo@codeaurora.org>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
should describe what system call is being called and what its arguments are.


Dmitry V. Levin (15):
  Move EM_HEXAGON to uapi/linux/elf-em.h
  Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
  Move EM_UNICORE to uapi/linux/elf-em.h
  elf-em.h: add EM_NDS32
  elf-em.h: add EM_XTENSA
  m68k: define syscall_get_arch()
  arc: define syscall_get_arch()
  c6x: define syscall_get_arch()
  h8300: define syscall_get_arch()
  hexagon: define syscall_get_arch()
  nds32: define syscall_get_arch()
  nios2: define syscall_get_arch()
  riscv: define syscall_get_arch()
  unicore32: define syscall_get_arch()
  xtensa: define syscall_get_arch()

 arch/arc/include/asm/elf.h           |  6 +-----
 arch/arc/include/asm/syscall.h       | 10 ++++++++++
 arch/c6x/include/asm/syscall.h       |  7 +++++++
 arch/h8300/include/asm/syscall.h     |  5 +++++
 arch/hexagon/include/asm/elf.h       |  6 +-----
 arch/hexagon/include/asm/syscall.h   |  8 ++++++++
 arch/m68k/include/asm/syscall.h      | 12 ++++++++++++
 arch/nds32/include/asm/syscall.h     |  8 ++++++++
 arch/nios2/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/syscall.h     | 10 ++++++++++
 arch/unicore32/include/asm/elf.h     |  3 +--
 arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
 arch/xtensa/include/asm/syscall.h    |  7 +++++++
 include/uapi/linux/audit.h           | 15 +++++++++++++++
 include/uapi/linux/elf-em.h          |  7 +++++++
 15 files changed, 110 insertions(+), 12 deletions(-)
 create mode 100644 arch/m68k/include/asm/syscall.h
 create mode 100644 arch/unicore32/include/asm/syscall.h

-- 
ldv
