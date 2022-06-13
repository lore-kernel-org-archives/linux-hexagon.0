From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Date: Mon, 13 Jun 2022 16:26:49 +0000
Message-ID: <c82877aa7cc244f2bf0f65dfb2b617e7@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com>
 <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
 <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655137612; x=1686673612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxsfHurYfgtl5B8eDXs3NdPaSjArXVczaB+F2Bn9Ek4=;
  b=HkYwqi5rbxVLCa9DjzarYkrq7QLAZ9qJ+s2gNJJwnWp97qJXWFbwlbvj
   IgCLX29aH7yIYuWMl01dpUNPIDxsoDHK4/eQASqiKWGDvI7LVFYFOfpoZ
   g8qKp7GTjIwLLvVwojxp+7wVKL0jJf3q5LYQL07wmecV23KQqc7jHX9mj
   FEcLj7QyRIoInFaPDChRUQRrILOt9Vq3z6+jiYvoFTjl2qp74Svl0d3kW
   qsR2JrznwCwY6XBuyr1iQ89ASkG0udTU0SoUX6lbIM6ZwLEMi1NB0RSz8
   uZYyXaT9sqqRa1ZQkBo7IDws7JCuI55fqO+uj+L+shaJqgZTeOOenbFo3
   A==;
In-Reply-To: <20220613141947.1176100-1-alexandr.lobakin@intel.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: "Lobakin, Alexandr" <alexandr.lobakin@intel.com>, Marco Elver <elver@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k@lists.linux-m6

>> It's listed in Documentation/atomic_bitops.txt.
>
> Oh, so my memory was actually correct that I saw it in the docs
> somewhere.
> WDYT, should I mention this here in the code (block comment) as well
> that it's atomic and must not lose `volatile` as Andy suggested or
> it's sufficient to have it in the docs (+ it's not underscored)?

I think a comment that the "volatile" is required to prevent re-ordering
is enough.

But maybe others are sufficiently clear on the meaning? I once wasted
time looking for the non-atomic __test_bit() version (to use in some code
that was already protected by a spin lock, so didn't need the overhead
of an "atomic" version) before realizing there wasn't a non-atomic one.

-Tony
