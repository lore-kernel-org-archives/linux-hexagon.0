From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 16:14:01 -0700
Message-ID: <202305301611.34F0A680A2@keescook>
References: <20230529052821.58175-1-maninder1.s@samsung.com>
 <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
 <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
 <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
 <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488442; x=1688080442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43Cq77dQ/zrfTfrqcrXS896rxBWu+H66vhJzdZh3Sqc=;
        b=RhGkv/UgqOw2a+M5Bu2/ULyGBQHPPzkrDPUyaz2nTpMZKESlZL2wEfrXpNPy/E35Hr
         ib+DwzUKBebWVZvTvFVKLXFT2yOi+8DwafPBMdk6e5LBlSa0kUzutXwe+POZ6/MXpZUy
         jLVOubfaaSTjXFX0n7gXFj1P1vIMR+TjHUfLM=
Content-Disposition: inline
In-Reply-To: <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maninder1.s@samsung.com, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Onkarnath <onkarnath.1@samsung.c>

On Mon, May 29, 2023 at 04:50:45PM +0200, Miguel Ojeda wrote:
> Kees: what is the current stance on `[static N]` parameters? Something like:
> 
>     const char *kallsyms_lookup(unsigned long addr,
>                                 unsigned long *symbolsize,
>                                 unsigned long *offset,
>     -                           char **modname, char *namebuf);
>     +                           char **modname, char namebuf[static KSYM_NAME_LEN]);
> 
> makes the compiler complain about cases like these (even if trivial):
> 
>     arch/powerpc/xmon/xmon.c:1711:10: error: array argument is too small;
>         contains 128 elements, callee requires at least 512
> [-Werror,-Warray-bounds]
>             name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
>                  ^                                           ~~~~~~
>     ./include/linux/kallsyms.h:86:29: note: callee declares array
> parameter as static here
>             char **modname, char namebuf[static KSYM_NAME_LEN]);
>                                  ^      ~~~~~~~~~~~~~~~~~~~~~~

Wouldn't that be a good thing? (I.e. complain about the size mismatch?)

> But I only see 2 files in the kernel using `[static N]` (from 2020 and
> 2021). Should something else be used instead (e.g. `__counted_by`),
> even if constexpr-sized?.

Yeah, it seems pretty uncommon. I'd say traditionally arrays aren't
based too often, rather structs containing them.

But ultimately, yeah, everything could gain __counted_by and friends in
the future.

-- 
Kees Cook
