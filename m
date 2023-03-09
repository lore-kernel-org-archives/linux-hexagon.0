From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Fri, 10 Mar 2023 09:54:27 +1100
Message-ID: <874jqtpmcc.fsf@mpe.ellerman.id.au>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1678402469;
	bh=HnGqhsJTeGjqlPVUTmz3g9ouF0ULtGaBV4DNsEeVxsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qtChMEayOa7BG3gV8biPN1UquvZjKKHH1PLnOktZLFk+z7+30lmoHFQWG/ybTGOfV
	 Msn+vq0214G/5bCC5sK8YEWC4SONYn3IjVV2gLKa55Cy0vLJqZpwyIgKHr5xpyRlRO
	 2B59x+JG32iD6Ll1IeACkY+jSFZ42uC6mHr940GQ8rZCqsWJ73oUfODgJNTU1QA4cH
	 /Zt2BN0brA6nfVHnuvaamrjV+75syVJwmQZUAWs6jzdNGb6ONfyH1iskU2QALlqqJR
	 fcr5fnsHZCG3RA30SBInWnaih8rWQ8VzjneqbRw1yHLKc3Q/ihjyNUCZJzzzjHFnUd
	 puglrrgtkl1qg==
In-Reply-To: <20230308130710.368085-4-bhe@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Baoquan He <bhe@redhat.com>, arnd@arndb.de, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org, mcgrof@kernel.org, geert@linux-m68k.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Baoquan He <bhe@redhat.com> writes:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior. So remove the ioremap_uc() definition in architecutures
> other than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
>
> This changes the existing behaviour, while no need to worry about
> any breakage because in the only callsite of ioremap_uc(), code
> has been adjusted to eliminate the impact. Please see
> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
>
> If any new invocation of ioremap_uc() need be added, please consider
> using ioremap() intead or adding a ARCH specific version if necessary.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  Documentation/driver-api/device-io.rst | 9 +++++----
>  arch/alpha/include/asm/io.h            | 1 -
>  arch/hexagon/include/asm/io.h          | 3 ---
>  arch/m68k/include/asm/kmap.h           | 1 -
>  arch/mips/include/asm/io.h             | 1 -
>  arch/parisc/include/asm/io.h           | 2 --
>  arch/powerpc/include/asm/io.h          | 1 -

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
