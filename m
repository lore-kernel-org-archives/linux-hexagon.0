Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1514EB857
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164477; cv=none; b=SxN7WJZxAdWYgSt2mKL4bUIY1GykPNq0OtlfnokZvOmu5rSqbXWG2arTBg0O0BYPPFNXJZBNRGuA2jP4G3v0RB7KcWsr7gWORK8M4DW6CH8fcMou/6kJCKnCqfDs/m9ryNoRFieY66ZfSx+kDEe5IWKVwZuQVOiD6EcW0G5sRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164477; c=relaxed/simple;
	bh=FyI8OIcx4NePB4wjfBisQg331Da0UMxOk3af3KkO/oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzvbo1b+JD4ZH9uquuiPRId7twEgnRGBDOX8cNUEuGEDrWt78w9XeTJK0H5INRTQlPodggjB3ScwyLAVXKGG9Ny02SuYlHo2f5MYikRGj0fHWrNqJ4jnuuaA+aq/30BCyW7fPKJNMHvWbg/1Nqhs+X47o+bumFKjtnzrESVOlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yoyk1T5Y; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yoyk1T5Y"
X-Envelope-To: linux-hexagon@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FyI8OIcx4NePB4wjfBisQg331Da0UMxOk3af3KkO/oU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790164468; v=1; x=1790769268;
 b=Yoyk1T5YZJaSwe52vnDqH1yWOQttHqPJR+z2Eyk1iuyMzMp/jYS2XdN/eycZbUEgr2rJLff+
 Qj29huo1/Tw9A1rSTPTdWEf6dLDv1I4okHpQj8oJyTHfNhO0w2srxfmg9vgGpnbAosQnTpnpv96
 SW51nI2y5IoGzusEzwmuZDEs=
X-Envelope-To: linux-hexagon@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b457f4ea14dabe32;
	Wed, 23 Sep 2026 11:54:26 +0000
X-Mizu-Trace-ID: b457f4ea14dabe32
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Date: Wed, 23 Sep 2026 19:54:17 +0800
Message-ID: <20260923115417.34112-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:39PM +0100, Lorenzo Stoakes (ARM) wrote:
>Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
>RCU page table freeing.
>
>sh-X2 is problematic because it utilises slab-allocated PMD page tables,
>and thus tlb_remove_ptdesc() cannot be used in these cases.
>
>All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
>convert some architectures to use tlb_remove_ptdesc()") already converted
>page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
>grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>
>Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
>for sh-X2, so the arch can provide its own __tlb_remove_table()
>implementation (called after the RCU grace period).
>
>Then, convert __pmd_free_tlb() to tag the pointer to the PMD, and have
>__tlb_remove_table() check this tag to determine whether to free via the
>slab or to use pagetable_dtor_free().

Makes sense to me, so RCU callback won't mistake a slab PMD for a PTE
page :)

>This follows the pattern used by sparc64 as implemented in commit
>4a0100f7546f ("sparc64: use RCU page table freeing").
>
>Previously __pmd_free_tlb() freed PMD page tables immediately, before any
>TLB flush IPI. This seems to be a pre-existing bug, which this change also
>resolves.
>
>CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is only specified for sh-X2, as setting
>it disables CONFIG_PT_RECLAIM and causes __tlb_remove_table_one() to call
>tlb_remove_table_sync_rcu() and synchronize_rcu() in turn, and this is not
>necessary for other sh variants.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

LGTM, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>
