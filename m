From: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2 00/15] Prepare for PTRACE_GET_SYSCALL_INFO
Date: Tue, 20 Nov 2018 15:26:53 -0500
Message-ID: <CAHC9VhQDs8cMuR4PXDB2VZ9TEtDydyBF_EqBGvjML+NN8+2LNw@mail.gmail.com>
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHQXYBlESi9ND8yKpEZyLeSHKrDeqYCCB7KMnHp3wz4=;
        b=K52MWwN4ZRoyx9SF9Eyvj7Jyts2CQ+MEZqbNVDhDyXca4haI0UcJ8Lkv/y+FtDmeBg
         ohcKHtN2IjxdDLDpBRPD7AFse9UtwiEA94kml4bF4TUQWF7VWx61mZjG6u6eVwdgz99r
         cTeTnZ6nV5Yb13wJTsU24NsYf0VUc8cUxq0D8ixW/k9/g9/v7t2HAp90YOdTYDSj9UDX
         Wni1FGeW6cI9ru3Co79/zgQ+VgxuGTMwy7IGH/LW4r0ikbdl/DVX+Ym/ERLrPFfZzGHV
         jx0AGwlpzcd4t7SVezhAVB4p+SeQGhOiHsRRqrvCa7W2q3+FgrimddCpRPAqoRvd+qhC
         3g9Q==
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ldv@altlinux.org
Cc: luto@kernel.org, lineprinter@altlinux.org, aou@eecs.berkeley.edu, alexey.brodkin@synopsys.com, jacquiot.aurelien@gmail.com, chris@zankel.net, Eric Paris <eparis@redhat.com>, geert@linux-m68k.org, green.hu@gmail.com, lftan@altera.com, msalter@redhat.com, jcmvbkbc@gmail.com, palmer@sifive.com, rkuo@codeaurora.org, deanbo422@gmail.com, vgupta@synopsys.com, ysato@users.sourceforge.jp, linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, nios2-dev@lists.rocketboards.org, uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 7:11 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> request.
>
> The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
> should describe what system call is being called and what its arguments are.

No real comment from me, most of this is arch specific code so I'll
let the individual arch folks comment on that; they know far better
than I do what is correct.

That said, anything that gets us closer to being able to offer syscall
auditing for these arches gets a big thumbs up from me - thanks!

> Dmitry V. Levin (15):
>   Move EM_HEXAGON to uapi/linux/elf-em.h
>   Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
>   Move EM_UNICORE to uapi/linux/elf-em.h
>   elf-em.h: add EM_NDS32
>   elf-em.h: add EM_XTENSA
>   m68k: define syscall_get_arch()
>   arc: define syscall_get_arch()
>   c6x: define syscall_get_arch()
>   h8300: define syscall_get_arch()
>   hexagon: define syscall_get_arch()
>   nds32: define syscall_get_arch()
>   nios2: define syscall_get_arch()
>   riscv: define syscall_get_arch()
>   unicore32: define syscall_get_arch()
>   xtensa: define syscall_get_arch()
>
>  arch/arc/include/asm/elf.h           |  6 +-----
>  arch/arc/include/asm/syscall.h       | 10 ++++++++++
>  arch/c6x/include/asm/syscall.h       |  7 +++++++
>  arch/h8300/include/asm/syscall.h     |  5 +++++
>  arch/hexagon/include/asm/elf.h       |  6 +-----
>  arch/hexagon/include/asm/syscall.h   |  8 ++++++++
>  arch/m68k/include/asm/syscall.h      | 12 ++++++++++++
>  arch/nds32/include/asm/syscall.h     |  8 ++++++++
>  arch/nios2/include/asm/syscall.h     |  6 ++++++
>  arch/riscv/include/asm/syscall.h     | 10 ++++++++++
>  arch/unicore32/include/asm/elf.h     |  3 +--
>  arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
>  arch/xtensa/include/asm/syscall.h    |  7 +++++++
>  include/uapi/linux/audit.h           | 15 +++++++++++++++
>  include/uapi/linux/elf-em.h          |  7 +++++++
>  15 files changed, 110 insertions(+), 12 deletions(-)
>  create mode 100644 arch/m68k/include/asm/syscall.h
>  create mode 100644 arch/unicore32/include/asm/syscall.h

-- 
paul moore
www.paul-moore.com
