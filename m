From: Steven Price <steven.price@arm.com>
Subject: [PATCH v3 07/34] hexagon: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:41 +0000
Message-ID: <20190227170608.27963-8-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-mm@kvack.org
Cc: Steven Price <steven.price@arm.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kerne

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For hexagon, we don't support large pages, so add a stub returning 0.

CC: Richard Kuo <rkuo@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/hexagon/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 65125d0b02dd..422e6aa2a6ef 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -281,6 +281,11 @@ static inline int pmd_bad(pmd_t pmd)
 	return 0;
 }
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return 0;
+}
+
 /*
  * pmd_page - converts a PMD entry to a page pointer
  */
-- 
2.20.1

