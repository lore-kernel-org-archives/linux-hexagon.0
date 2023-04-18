From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
Date: Tue, 18 Apr 2023 17:45:03 +0200
Message-ID: <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bJt9A6RNcEb2U6B5tDYSF5FW7H+XG/yzaWW7RKwGd0k=; b=kHy+12xpMzOR7e
	2SZ7sFlVTZfqBmSkk9FYo6p0eCqrtD9RQX14utP7CsVByOhxoIRwfAVXE8t7kDRnKt55EIfoOz5UV
	xm6mn3RubDgv3Oj49X9ltwmPOv9+su5z+dHhJtxSrI7BIkfXnuaIUOcPIMkPpmB3P83juxcBeC4h/
	XCQmGxIve57Yx23ethdD4am1uPqDJwnEXLXt1q3c90wtG/gIzRsJ59nW7g8DRVQ600cyV1GBzGBgl
	3FYAREtppVy+kEY7EW7E4Wlt3xMD7CDyPIDIdJEl5vej+KJRTfzGqN+HiEPt5+gY2w0ZZWIoEpYT8
	WNa42r9vpD5EtyFWll0A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681832711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27YuiGTc/1Ayk3pIwHwifC0cK9cQSm41NYDsP6qMI7E=;
	b=U8JMYrlgiEj994b1hrSfSqrDjhhXCK47LNEPZZlIOsQi+ZB22f0Al53zFXUWl8isy99rZY
	/qiEg+Isjo2jy6vWzMdVtAfsrkfsetV/WtgOJsiwFZmMyk40b0apRxF8eL5nY9q9Ll9Px2
	Hb+JKTRNdIWqNkGQHQPaweFerSjxz0U=
In-Reply-To: <20230417205048.15870-2-vishal.moola@gmail.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
> s390 uses page->index to keep track of page tables for the guest address
> space. In an attempt to consolidate the usage of page fields in s390,
> replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
> 
> This will help with the splitting of struct ptdesc from struct page, as
> well as allow s390 to use _pt_frag_refcount for fragmented page table
> tracking.
> 
> Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
> before freeing the pages as well.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

[...]

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fc9e680f174..2616d64c0e8c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -144,7 +144,7 @@ struct page {
>   		struct {	/* Page table pages */
>   			unsigned long _pt_pad_1;	/* compound_head */
>   			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> -			unsigned long _pt_pad_2;	/* mapping */
> +			unsigned long _pt_s390_gaddr;	/* mapping */
>   			union {
>   				struct mm_struct *pt_mm; /* x86 pgds only */
>   				atomic_t pt_frag_refcount; /* powerpc */

The confusing part is, that these gmap page tables are not ordinary 
process page tables that we would ordinarily place into this section 
here. That's why they are also not allocated/freed using the typical 
page table constructor/destructor ...

-- 
Thanks,

David / dhildenb
