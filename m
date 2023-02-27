From: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v5 1/7] arch: rename all internal names
 __xchg to __arch_xchg
Date: Mon, 27 Feb 2023 10:53:03 +0100
Message-ID: <Y/x9fxS1cFsa1ylP@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677491596; x=1709027596;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dwUo3BFORgMJVeDfksL8jP7HkkuWEuVDbhgyCpyAFqs=;
 b=XiETXY2S2vPWGu9yDgaMGervupGgpNAWSnf2uSqMAHhwMJJL+zL/QsN2
 E7PMdb4TlNTzlZY5bCYQLkg3plUcz/9Wm8Z6h0W3T6Gkz/KBlUNhMg5mG
 iGxsJFULGkbNS3ee+lVGpI8OvkAIug+PHTZVCUh8n+Zs0a5iqZFItgFk6
 RhBSWw1Z5cUvjIQDd/EjeTZdl3SI2ZkHpxVUI4cLF25wC6C/ciJpIJRH3
 WVVvjqJuEo7Ne1DGMHjThUSQ644fO09YGnHNm9i0KMg7GycktKHBzTxwc
 dBkJVjchVfVnpXkdIxK8Jpdnp68mCta/TBVx9zhsJRapClhcz6j8iunkU w==;
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-1-andrzej.hajda@intel.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-snps-arc@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Palmer Dabbelt <palmer@rivosinc.com>, loongarch@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:44PM +0100, Andrzej Hajda wrote:
> __xchg will be used for non-atomic xchg macro.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> [riscv]

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
