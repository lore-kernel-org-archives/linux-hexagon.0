From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
Message-ID: <mhng-fae2ea79-c261-4e5d-8eae-21e60810a957@palmerdabbelt-glaptop>
References: <20210731052233.4703-2-masahiroy@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=6nR9aX/QVdFygrTD2IVeHOaN5/rV2NQhNSHli3tRxJ0=; b=tDXfwHfqZSKdtILyY5B3nGf47I
	Xq/r8ezQqmbGlij/JwUsilu9xeP1TctySvfSBQz9xH0UjJeeUEG3CM3U+1vaQUDpgc8jZbClhHTtg
	GCc2Hrduo+OM+j623bvPhP5xklytesLYTXN6MWhw5kuAh+MBjiUL2lCTj+154XgBYBSi08mfzHVyU
	j6riIWHczS5+uPncIlfibl2VUgDHzAyqw0tRLaz+q5LensR30edYZJeuAn6yAJrWNUAGXIAcezkDV
	zsvvIX8lvLuRruKLMnw8CpRYNW+oXC99u4hOnK8tYxL9t3vsRs1lO4szGNeVSdm6M4OLjnZSn7gDp
	ACSlkGXw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=CbvF3gcMl15CsJvEJlvAwV4jg0kS7/1c0/243X9NmVQ=;
 b=nS8Xfv5Np514ewOr71qM5OVYQ4om375+9iia5AAYDaK3OM+hzJenuJr7dAU5cYremk
 lMJSdk/H6gRuWyoAZ38Dxo4xTOwzwlYBTQ7mHvrJGvY2eRlpd9btrTwCc/T4R+lnp2Oz
 tfjjB9XYA84IA+sxs7E0+0bjR3ImZY/NCblTCqWV1vz8ngiUx+QRlaWbVMisVRWW3rOO
 yK85Pgi7JMY0nVAg9WrPZrM52PG/5lW+DmvVcQIgBTfNfdcKCdUHJCl4J+hHtwrGzLzq
 JQXK/nMftIjnNhxqPt/IHdPMmbV0SixoX/iiQ7rUV+IDNkS5Y0uflbsJwBJg2KghrkLe
 Gahg==
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: rostedt@goodmis.org, mingo@redhat.com, masahiroy@kernel.org, Arnd Bergmann <arnd@arndb.de>, ardb@kernel.org, bp@alien8.de, linus.walleij@linaro.org, ley.foon.tan@intel.com, x86@kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, anshuman.khandual@arm.com, nickhu@andestech.com, tglx@linutronix.de, rppt@kernel.org, geert@linux-m68k.org, peterz@infradead.org, catalin.marinas@arm.com, linux-riscv@lists.infradead.org, yifeifz2@illinois.edu, green.hu@gmail.com, monstr@monstr.eu, deller@gmx.de, linux-sh@vger.kernel.org, vgupta@synopsys.com, u.kleine-koenig@pengutronix.de, guoren@kernel.org, samitolvanen@google.com, richard@nod.at, borntraeger@de.ibm.com, dalias@libc.org, aou@eecs.berkeley.edu, hca@linux.ibm.com, jdike@addtoit.com, jcmvbkbc@gmail.com, linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org, hpa@zytor.com, will@kernel.org, tsbogend

On Fri, 30 Jul 2021 22:22:32 PDT (-0700), masahiroy@kernel.org wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kconfig            | 4 +---

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
