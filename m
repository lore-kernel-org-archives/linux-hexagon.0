From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 00/13] Prepare for PTRACE_GET_SYSCALL_INFO
Date: Fri, 9 Nov 2018 06:13:04 +0300
Message-ID: <20181109031303.GA20906@altlinux.org>
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
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Albert Ou <aou@eecs.berkeley.edu>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Chris Zankel <chris@zankel.net>, Eric Paris <eparis@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Moore <paul@paul-moore.com>, Richard Kuo <rkuo@codeaurora.org>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org

syscall_get_arch() is required to be implemented on all architectures
that use tracehook_report_syscall_entry() in order to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Dmitry V. Levin (13):
  Move EM_HEXAGON to uapi/linux/elf-em.h
  elf-em.h: add EM_ARC
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
  xtensa: define syscall_get_arch()

 arch/arc/include/asm/syscall.h     |  6 ++++++
 arch/c6x/include/asm/syscall.h     |  6 ++++++
 arch/h8300/include/asm/syscall.h   |  5 +++++
 arch/hexagon/include/asm/elf.h     |  6 +-----
 arch/hexagon/include/asm/syscall.h |  8 ++++++++
 arch/m68k/include/asm/syscall.h    | 12 ++++++++++++
 arch/nds32/include/asm/syscall.h   |  7 +++++++
 arch/nios2/include/asm/syscall.h   |  6 ++++++
 arch/riscv/include/asm/syscall.h   |  6 ++++++
 arch/xtensa/include/asm/syscall.h  |  7 +++++++
 include/uapi/linux/audit.h         |  8 ++++++++
 include/uapi/linux/elf-em.h        |  5 +++++
 12 files changed, 77 insertions(+), 5 deletions(-)
 create mode 100644 arch/m68k/include/asm/syscall.h

-- 
ldv
