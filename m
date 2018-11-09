From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/13] Prepare for PTRACE_GET_SYSCALL_INFO
Date: Thu, 8 Nov 2018 22:06:13 -0800
Message-ID: <CALCETrUMnBxZ=-EWf5TJY9kqMA9Sy=mtk7OyS0tHub1+DREM=w@mail.gmail.com>
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181109031303.GA20906@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541743589;
        bh=edKnIOVpTAW8cmFcOoS4kpKzGT1Q4Tuvv+ifbrrxjA4=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=A71FZsUiKNNIV7YXMPdvTyc4/Ecnqw/yoyW3je+eNo8aWRr2x+q5UgM98IBLvMS4b
         f2D54NANChTBCkZNX+1MFrvhVv29eMmZ/Q/2wiQkG9UDoNXKLRK6XEfJxA0yKKwZBT
         4ku+iTHA5YqdvWeVey4ovBI7Z8kbX0Kh1q4kkFfM=
In-Reply-To: <20181109031303.GA20906@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Lutomirski <luto@kernel.org>, Elvira Khabirova <lineprinter@altlinux.org>, aou@eecs.berkeley.edu, jacquiot.aurelien@gmail.com, Chris Zankel <chris@zankel.net>, Eric Paris <eparis@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com, lftan@altera.com, Mark Salter <msalter@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, palmer@sifive.com, Paul Moore <paul@paul-moore.com>, Richard Kuo <rkuo@codeaurora.org>, deanbo422@gmail.com, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, nios

On Thu, Nov 8, 2018 at 7:13 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Nice!

I'm pretty sure you have vastly more changelog than code here :)

--Andy
