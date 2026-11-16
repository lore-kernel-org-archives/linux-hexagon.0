Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852645;
	b=ceBW3qbnPreK2U+oj3brFmZRG23aY1pUAYSu1kxpGOov6ms9rEfT0c59MPbjPbUJUtaH
	 4GBfruGfYlKjeWBKccx0AdfsyBV/plWcGyOsbDzZdYgkFUAdx/xer/p2HENCSjtHtbKWD
	 6OYe1thhf994mGmLFSzYTZcNjRQbpFkI4gewew/h0pJvmvlSeYA/EEo5WzHxjfQfgn9I7
	 Z4GKi73e8MfpBQIg/tqD6OD1+9j6nZo9Rp2njTOcqnBblan+tjJJSOGSKJ3qLa04vxyJf
	 onbdSey0N9yJZnoQv6ZHkQGsDLwtL9lvT9iQm0CvCnrRiBvnNcr4R+EjU7Lky+JaHtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
	b=cN8zvobybu+iESHMHbCTtF488UIqLg4yWcfvEnRZ0txijQjumepmUW8kCx9iDYzJWcmZ
	 R5yJ4tyTDoC3N1kehR4WOILeVau6YAWyQchgqhOM4DpJZdRpo1MjrJQYTaPq9Gxo9wyxW
	 c9jRS7s2wf5nhRbZPZD28saS7laUrNQ/GZaopgo91otAnJmMTSw1ovS/DOhRfrDnO52Xs
	 YPesi9iMgwrrwhNbRi9NR3Gx2amq6/pWkmSjOeOm4h4p+HWmZIuK/ncEywvfjuU35gK8a
	 o2gq1L75PN3zGKbqpzUfOTQr869k5XM+MTETf7VrkADNxVW+ToQBdQp5ULRbDk7QRTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0lt4j5h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39F606A322
	for <linux-hexagon@vger.kernel.org>; Mon, 16 Nov 2026 18:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E39F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0lt4j5h
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b8082af2ffso1893115a12.0
        for <linux-hexagon@vger.kernel.org>; Mon, 16 Nov 2026 10:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852643; cv=none;
        d=google.com; s=arc-20260327;
        b=T0hdWrQ99plq03BG/XDNj1gkW32IDjuxTGSfv0hPFAec6Sa5CKasjnj1XHQOBxSp4u
         CuVHg/08ppHjjoxI4lFScyYp+aZkGAi+QWGJiSizrSrmYphNE/3MMwAhpBQPLzf3rL+U
         h6Nmt4FHKXzWoNwPrIUBZq+u4TPMaLJfD+7K28TFE3XtUV1sHf+noULVEOFyEC9pOvAX
         sKfiBVWU/+JdTGBhod7K7EiwkW7caFw9bUB6xi/hs+96CU0+1JWt323YjSKkXho0WWQo
         LXLvAOrWoxKeui7U30dIdzW+yN6ykhYkFJtB7FEOaf8UGAddRy5B1E7RdoCfnAhr4Ggi
         EXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        fh=ZzeQ/9YhFITVVciDvr6LEPSsIzCESl6Rla8JUlhl85U=;
        b=QNQkPqShsiynhPWq/A/EaqgOSvQ4D81or3TyyGsEQ6jSsnBrII/qMfxCKuz9AubDgq
         euGl/CLDlR10ckzsAqvjXR+Ouxn9NiJYGjGlwOJxRxRBseGbXbUEeXMZe6zRzzpRsowa
         L6hW/yR/kXvM7YMJB7pTBUSnBg0HxsNgD+qbcrmFO39l5s9Xu0mHjipaegjHZMhf5eO3
         ltEMlE61bFFroUMul+0MQCxP7jWGN5IQ4FKVxr2bMDb0XhM9M1TJAnNRIn9c3MukP2tL
         bwYxZ5jtkB+BIA1I/NN4v0/Q8ybQ5H5HhWFFGDRWLxT2jmgzmmRApeI1bXGbxZrLn4+v
         4wWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794852643; x=1795457443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        b=x0lt4j5h7o5ZOIupC6QpocZBfmv8wFzUHnqEUjT+qXXHs4fqM/212o+JPya3Ne+Seo
         tLIn+ce71Roeft17QbgYTLYZCJ0+SlsLtt4o2OLm95aLJ5VyGYDhMzriK8UdMTHsHNnj
         8mTqTlr5/Ax8I+pLOcrqBMRwU57PT7keOGJO4t4tmQGJKRYz/1wZ/uaK+JY6cLy80yx1
         pkobwBcMhURP6h4GfSR12sTX8GLQ2Qvn5juEllVfsWcYtDCP4X7X2kujH+BqvT2pv+Ny
         N7Wj9fipbTOHczIeVSeB+l1xH0/w8nez4g0GJUB68vMGCquO73GzeOY0af50BLWOXJ1z
         6RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852643; x=1795457443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        b=hTL7ij0QwSV402rpmCLNFf0GLkgKMCHLnBqdLo1E1fuhTlLCnm0G2ScbdQZG/WV5U3
         zZdOH3MWMC8w6mxHZro/eyxgCdlFIhfl2rsvacfCHanCFjz7TNAsdZ8nulvDtBrb9S1K
         EKyPBxUrbbFzaam0ppY67zjknYZYIPcci7VHL8baZ6M342Xqku67RG0Ige77K+tBwg2k
         bkPUT6eOipED6gDoMRvA9X2C3GTlKCTWeNTIORn/U66TsqvhIDHnOEOPJauo76TgF24W
         +Km7FqqDMFaZFjAaksk6YpQzDGmzS2HK4MqED5VAMG5lEiSV3IGlF4rg+vEvnTIDVMKy
         QAWg==
X-Forwarded-Encrypted: i=1; AL+hErFMdYhZcauPFOXc0WcjMf1u4C7sAG6Njd10WdnDerecd2EVdUvJef97WpzSkkgO3Blywi/BhOeFGalB8Kco@vger.kernel.org
X-Gm-Message-State: APuU4Z+psQEexGW/dpp15DiZhzh0HjNgYJrwt0eKUM8MSHF90/pR0s6j
	SW8QcpdJscj1KGM9EcducAH+4v1aI9fjBZA1JOl7DJfc2s2Henr7qpd0z8mB7QL0IWZVF68bXRl
	7tb1flQQU7PUzRenjYbX9tq32HKINqlc=
X-Gm-Gg: AYBFou3Q1XHNGtPQk6AJBJAXrUJwJuaK93UChoXlXT2XA8LQIYkPJ9HshiCLHIItviE
	fT7WGwA/D9SEVzvbOESWOJwxTChny005MQouLJXyVdDKZWFAkNP2N9kp23L1wh10aFW9AJ+YxTT
	QhUcE5UDWx3QqiJ2igIz8j0Q+1gUTbBruvJUY1/bjIdR54hHYwx/IL/d9k6k9b9jqSCkbh94izF
	PgLnTFWKp22o6K/s7S+/dIsNKKCHex2Lq5qV7fPovuXch9df+qybyZO7hbjYXOB7cofaTTM4Dhv
	AIKAMUTXUquXwf2DWDH2e2X/xZxHe//+PBKI+XyN8oJ+LsEJIYIZXVM9uppFJ3htou7QeKQ9nKx
	ZdOKLeCGbKlWLULRSYpiNsyqKV4TlcU/8sVPx32Hum8E5wSngRLJlMBQizqF+8/yLfDBLMOeIkN
	/fc9mtOkFo3uoE7PMYTz4BX7lWuzl1qlcePgVNtCp77Ume
X-Received: by 2002:aa7:c4cc:0:b0:6b4:1037:2bb1 with SMTP id
 4fb4d7f45d1cf-6b7c0bc27a9mr6612692a12.22.1794852642773; Mon, 16 Nov 2026
 10:10:42 -0800 (PST)
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114184720.373178-1-renzo@cs.unibo.it> <20261114184720.373178-2-renzo@cs.unibo.it>
In-Reply-To: <20261114184720.373178-2-renzo@cs.unibo.it>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Nov 2026 19:10:30 +0100
X-Gm-Features: AclHuK-3zf0u-_tVqqSwOuwnlXe0JuQIB0eE-s6YSpQo7rK-ZYPGihb4jDlFOAE
Message-ID: <CA+=Fv5QPMYffznpkrEhZ3pMWtpHwNUUa3OaHxLexu8S47a7tRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] asm/ptrace.h: add instruction_pointer_set
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Eugene Syromyatnikov <evgsyr@gmail.com>, Davide Berardi <berardi.dav@gmail.com>, 
	"Dmitry V . Levin" <ldv@strace.io>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, strace-devel@lists.strace.io, 
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Renzo,

On Sat, Nov 14, 2026 at 7:47=E2=80=AFPM Renzo Davoli <renzo@cs.unibo.it> wr=
ote:
>
> Add an instruction_pointer_set function for architectures that do
> not currently provide one.
>
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
>  arch/alpha/include/asm/ptrace.h      | 6 ++++++
>  arch/hexagon/include/asm/ptrace.h    | 6 ++++++
>  arch/m68k/include/asm/ptrace.h       | 6 ++++++
>  arch/microblaze/include/asm/ptrace.h | 6 ++++++
>  arch/nios2/include/asm/ptrace.h      | 6 ++++++
>  arch/um/include/asm/ptrace-generic.h | 6 ++++++
>  arch/xtensa/include/asm/ptrace.h     | 6 ++++++
>  7 files changed, 42 insertions(+)
>
> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptr=
ace.h
> index 45d1229344b6..1a6f073e892e 100644
> --- a/arch/alpha/include/asm/ptrace.h
> +++ b/arch/alpha/include/asm/ptrace.h
> @@ -33,6 +33,12 @@ static __always_inline bool regs_irqs_disabled(struct =
pt_regs *regs)
>         return arch_irqs_disabled_flags(regs->ps);
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  /* Syscall emulation defines */
>  #define PTRACE_SYSEMU                  0x1d
>  #define PTRACE_SYSEMU_SINGLESTEP       0x1e
> diff --git a/arch/hexagon/include/asm/ptrace.h b/arch/hexagon/include/asm=
/ptrace.h
> index ed35da1ee685..0a121f6e3bfc 100644
> --- a/arch/hexagon/include/asm/ptrace.h
> +++ b/arch/hexagon/include/asm/ptrace.h
> @@ -18,6 +18,12 @@ extern const char *regs_query_register_name(unsigned i=
nt offset);
>         ((struct pt_regs *) \
>          ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #if CONFIG_HEXAGON_ARCH_VERSION >=3D 4
>  #define arch_has_single_step() (1)
>  #endif
> diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrac=
e.h
> index bc86ce012025..6e8a8f0daee8 100644
> --- a/arch/m68k/include/asm/ptrace.h
> +++ b/arch/m68k/include/asm/ptrace.h
> @@ -18,6 +18,12 @@
>         (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) -=
 1
>  #define current_user_stack_pointer() rdusp()
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #define arch_has_single_step() (1)
>
>  #ifdef CONFIG_MMU
> diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/inclu=
de/asm/ptrace.h
> index 17982292a64f..69e10658d7a9 100644
> --- a/arch/microblaze/include/asm/ptrace.h
> +++ b/arch/microblaze/include/asm/ptrace.h
> @@ -20,5 +20,11 @@ static inline long regs_return_value(struct pt_regs *r=
egs)
>         return regs->r3;
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* _ASM_MICROBLAZE_PTRACE_H */
> diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptr=
ace.h
> index 96cbcd40c7ce..d120d8ecb187 100644
> --- a/arch/nios2/include/asm/ptrace.h
> +++ b/arch/nios2/include/asm/ptrace.h
> @@ -70,6 +70,12 @@ struct switch_stack {
>  #define user_stack_pointer(regs)       ((regs)->sp)
>  extern void show_regs(struct pt_regs *);
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #define current_pt_regs() \
>         ((struct pt_regs *)((unsigned long)current_thread_info() + THREAD=
_SIZE)\
>                 - 1)
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/p=
trace-generic.h
> index 62e9916078ec..632d4ce3334d 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -29,6 +29,12 @@ struct pt_regs {
>
>  #define PTRACE_OLDSETOPTIONS 21
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #ifdef CONFIG_BINFMT_ELF_FDPIC
>  #define PTRACE_GETFDPIC                31
>  #define PTRACE_GETFDPIC_EXEC   0
> diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/p=
trace.h
> index d0568ff6d349..97b14418955e 100644
> --- a/arch/xtensa/include/asm/ptrace.h
> +++ b/arch/xtensa/include/asm/ptrace.h
> @@ -103,6 +103,12 @@ static inline unsigned long regs_return_value(struct=
 pt_regs *regs)
>         return regs->areg[2];
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  int do_syscall_trace_enter(struct pt_regs *regs);
>  void do_syscall_trace_leave(struct pt_regs *regs);
>
> --
> 2.47.3
>

The Alpha change looks good and applies cleanly on my for-next,
including the generic-entry fixes.

Tested both series together on my AlphaServer ES40. The ptrace
selftests passed on all three CPUs, including syscall skipping
and instruction-pointer modification.

For the Alpha part:

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus
