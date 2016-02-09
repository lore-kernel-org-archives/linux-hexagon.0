From: David Long <dave.long@linaro.org>
Subject: [PATCH v3 0/2] Consolidate redundant register/stack access code
Date: Tue,  9 Feb 2016 00:38:55 -0500
Message-ID: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=8RNp1/RfoXIdBQl6sLf1WT+XwxYkO5Xj5h3z/Bp9Sgo=;
        b=UwnoWf7OjH5N4+IGth7PRP1wHCc/f071q5zjk38jp0QxTUcAaOKevl+j/MkDo/bzP6
         KM04k/WOpLiblqmpBl0nCksUnOR7iMfl7GMdnWrOsI56kfzlCkTREoOrFZDZxWUfLRLo
         7fmVrxVS4t9nfzvhSQWVCi3X+y6Q/YMdBvOL8=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Denys Vlasenko <dvlasenk@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>, Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@lin>

From: "David A. Long" <dave.long@linaro.org>

Move duplicate and functionally equivalent code for accessing registers
and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
common kernel files.

I'm sending this out again (with updated distribution list) because v2
just never got pulled in, even though I don't think there were any
outstanding issues.

Changes since v1:
	Move the REG_OFFSET_NAME and REG_OFFSET_END macros to architecture-
	independent include file.

Changes since v2:
	No material changes, just merge up to v4.5-rc2.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

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
2.5.0
