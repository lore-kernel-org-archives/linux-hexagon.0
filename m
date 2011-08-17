From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 04/36] Hexagon: Add atomic ops support
Date: Wed, 17 Aug 2011 21:20:36 +0200
Message-ID: <1892721.uUY0g5DXJQ@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.243028227@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163520.243028227@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:01 Richard Kuo wrote:
> +/**
> + * atomic_add_unless - add unless the number is a given value
> + * @v: pointer to value
> + * @a: amount to add
> + * @u: unless value is equal to u
> + *
> + * This is actually in the asm-generic version; should revisit this
> + * entire file...
> + */
> +static inline int __atomic_add_unless(atomic_t *v, int a, int u)
> +{
> +       int c, old;
> +
> +       c = atomic_read(v);
> +       for (;;) {
> +               if (unlikely(c == u))
> +                       break;
> +               old = atomic_cmpxchg((v), c, c + a);
> +               if (likely(old == c))
> +                       break;
> +               c = old;
> +       }
> +       return c != u;
> +}

It's probably worth doing this in a single inline assembly instead
of two nested loops (the second one being inside of atomic_cmpxchg.

	Arnd
