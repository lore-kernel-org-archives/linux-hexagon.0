From: David Long <dave.long@linaro.org>
Subject: [PATCH 0/2] Consolidate redundant register/stack access code
Date: Mon, 15 Jun 2015 12:42:57 -0400
Message-ID: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, 

From: "David A. Long" <dave.long@linaro.org>

Move duplicate and functionally equivalent code for accessing registers
and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
common kernel files.

Note: Help regression testing s390, hexagon, and sh would be appreciated.
      Powerpc builds but I have not verified the functionality.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

 arch/arm/include/asm/ptrace.h          |  6 ---
 arch/arm/kernel/ptrace.c               | 72 +---------------------------------
 arch/hexagon/include/uapi/asm/ptrace.h |  3 --
 arch/powerpc/include/asm/ptrace.h      | 38 ------------------
 arch/powerpc/kernel/ptrace.c           | 39 +-----------------
 arch/s390/include/asm/ptrace.h         |  3 --
 arch/s390/kernel/ptrace.c              | 70 ++++++++++-----------------------
 arch/sh/include/asm/ptrace.h           | 44 ---------------------
 arch/sh/kernel/Makefile                |  2 +-
 arch/sh/kernel/ptrace.c                | 33 ----------------
 arch/sh/kernel/ptrace_32.c             |  2 +-
 arch/sh/kernel/ptrace_64.c             |  2 +-
 arch/x86/include/asm/ptrace.h          | 37 -----------------
 arch/x86/kernel/ptrace.c               | 39 +-----------------
 include/linux/ptrace.h                 | 51 ++++++++++++++++++++++++
 kernel/ptrace.c                        | 38 ++++++++++++++++++
 16 files changed, 116 insertions(+), 363 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

-- 
1.8.1.2

