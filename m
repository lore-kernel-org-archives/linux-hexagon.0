From: David Long <dave.long@linaro.org>
Subject: [PATCH v2 0/2] Consolidate redundant register/stack access code
Date: Mon, 27 Jul 2015 00:39:32 -0400
Message-ID: <1437971974-2434-1-git-send-email-dave.long@linaro.org>
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

Changes since v1:
    Move the REG_OFFSET_NAME and REG_OFFSET_END macros to architecture-
    independent include file. Change their name from REG_* to REGS_* for
    consistency.

Note: Help regression testing s390, hexagon, and sh would be appreciated.
      Powerpc builds but I have not verified the functionality.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

 arch/arm/include/asm/ptrace.h          |   6 --
 arch/arm/kernel/ptrace.c               |  74 +---------------
 arch/hexagon/include/uapi/asm/ptrace.h |   3 -
 arch/powerpc/include/asm/ptrace.h      |  38 --------
 arch/powerpc/kernel/ptrace.c           |  65 +++-----------
 arch/s390/include/asm/ptrace.h         |   3 -
 arch/s390/kernel/ptrace.c              |  69 +++++----------
 arch/sh/include/asm/ptrace.h           |  48 +---------
 arch/sh/kernel/Makefile                |   2 +-
 arch/sh/kernel/ptrace.c                |  33 -------
 arch/sh/kernel/ptrace_32.c             |  50 +++++------
 arch/sh/kernel/ptrace_64.c             | 154 ++++++++++++++++-----------------
 arch/x86/include/asm/ptrace.h          |  37 --------
 arch/x86/kernel/ptrace.c               |  93 ++++++--------------
 include/linux/ptrace.h                 |  54 ++++++++++++
 kernel/ptrace.c                        |  38 ++++++++
 16 files changed, 258 insertions(+), 509 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

-- 
1.8.1.2

