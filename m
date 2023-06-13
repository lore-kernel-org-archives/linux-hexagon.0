From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Date: Tue, 13 Jun 2023 16:14:10 +0000
Message-ID: <13a368447d2c64d09b69fa7d1556dd9ea55f70b7.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
	 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
	 <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3/KjlD3vRfvLmWUUZuTuwlLmdHzspje4NeVcxzuDoTQ=; b=R2Qioi6eXmlidT
	SWzH9jJBVdXd+V2pWr/vXkbU9h3SZXgDVzA3pVPxj/N0HaigM6WpNQ0UTNU6gN+tn1Xic9jIIuzXp
	lekLpVpVbn6YjzuPes3193ASjawlOXX34IFYMkNnnRMbDr4sx2Uidilvlt3g4zqZ92T/MSfQ3tcAX
	KuVfb6UnsxyLpngFhiCyeiiK8vMtWdjDYpS/PWuZRok1QUMa6oGDEhiSp/81wuYY9jrUGm0xVNeg6
	rzMgFJRwjUDWntFl8WT96cUJD92g+avrTl6j+CyW5cCl/64IZmtK2r5FxvQZVrAsNwrrGIFVbyJvp
	r3uMIIp9jNQ4+BNObjaQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673002; x=1718209002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C5Ys1f9+JE7Bmibl52QMo05WseGH+YcevQbOApSKGbw=;
  b=JwOoBtY5zNBogIYrPhvmnGqMrKBWJvIAAFyYdBCUWrzsla+F7/oGhTAa
   eRd2oNht9R4iuTB1IDHaFMBJtQfrgzZ+nzsWzKo7T6L+bzNvuu2o5EflC
   VZhCZksS8GD77k2N59PPjRooH+6QBVRzO7u3oEq034BezVUY0WfpgQgh0
   EBT+EANGNzIzQr5Zux712eV7jhJJ/oyG8VFdRbXKUDq1ebp2mLYyfyH3N
   FMn2ThQkUDmgD0JrNOgIHWXZEMcSsMKg1IuikrhNsyiO7YBIWXg11oqmn
   sUskc5bx8vpCr9HeQUsvpO8zLWoGnXg4zxupZBkAQMG6Qf0erPO7W4AHg
   A==;
In-Reply-To: <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
Content-Language: en-US
Content-ID: <8CB5F580BF0FAB4999F6807B618856D7@namprd11.prod.outlook.com>
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
To: "geert@linux-m68k.org" <geert@linux-m68k.org>
Cc: "Schimpe, Christina" <christina.schimpe@intel.com>, "Yang, Weijiang" <weijiang.yang@intel.com>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "rppt@kernel.org" <rppt@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Torvalds, Linus" <torvalds@linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "Lutomirski, Andy" <luto@kerne>

On Tue, 2023-06-13 at 09:19 +0200, Geert Uytterhoeven wrote:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!
