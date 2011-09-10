From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Sat, 10 Sep 2011 08:42:26 +0200
Message-ID: <CACM3HyH8P=u9pR0sa2besxsgDN5TUKg_7utLJTwL+hu8Wv48ow@mail.gmail.com>
References: <20110909010847.294039464@codeaurora.org>
	<20110909010916.525482401@codeaurora.org>
	<CACM3HyGvJQABO3Hi6e+yH+Xoi+S+fctGrH3w4Jm7=zqtnPTXTQ@mail.gmail.com>
	<20110909211808.GA3150@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=G2nzfAddEpi4UtNHi9P1dm/cCqm4rEH/kGtnJ4fVrmc=;
        b=w1V1V/SnWTxVdB/z677s6E3HT8IlJDomTdr81EcYdz5APNAok8KtyYMQuFN/jBKtmO
         MRv6iulkxoJrAndour8CZfPbI/kYVLIw+W8Xf/bw9WHjCcg5ZHeKrzgmtuCPJ5cWsCB0
         ir4x+GGgThi9rDe5HBPcl6yRmXOEP3YqNrCug=
In-Reply-To: <20110909211808.GA3150@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On 9 September 2011 23:18, Linas Vepstas (Code Aurora)
<linas@codeaurora.org> wrote:
> On Fri, Sep 09, 2011 at 10:15:20PM +0200, Jonas Bonn wrote:
>>
>> That said, I don't think gdbserver has been updated to use
>> GETREGSET/SETREGSET. =C2=A0This is a bit like the uClibc/glibc issue=
,
>
> Some dumb questions then: I notice that a few arches declare
> struct user_regs_struct in glibc, most of the others in the
> kernel. =C2=A0If I were to make pt_regs completely kernel-private,
> then I really do need to have struct user_regs_struct declared
> the kernel headers, right?

Yes, on OpenRISC we declare it in ptrace.h (see
arch/openrisc/include/asm/ptrace.h).

>
> Putting a printk into case PTRACE_POKEUSR seemed to show that
> gdb was using this (and was somehow mis-numbering the registers
> ... sigh.) Are you saying that the default should handle this?

I'm really not an expert on GDB, but I believe it can use either the
PEEK/POKE functions to access regs, or it can use GET/SETREGS; it's an
architecture-dependent configuration.  I think the second variant can
be easily modified to become GET/SETREGSET instead, and the PEEK/POKE
variant wouldn't be needed at all.

/Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
