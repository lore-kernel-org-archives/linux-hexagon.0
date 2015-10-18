From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.14 61/79] arch,hexagon: Convert smp_mb__*()
Date: Sat, 17 Oct 2015 19:05:53 -0700
Message-ID: <20151018020216.040310068@linuxfoundation.org>
References: <20151018020213.322172837@linuxfoundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151018020213.322172837@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Kuo <rkuo@codeaurora.org>, Vineet Gupta <vgupta@synopsys.com>, linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 94cf42f823bc904305b0ee93a09bcd51ba380497 upstream.

Hexagon uses asm-gemeric/barrier.h and its smp_mb() is barrier().
Therefore we can use the default implementation that uses smp_mb().

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/n/tip-87irqrrbgizeojjfdqhypud3@git.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/hexagon/include/asm/atomic.h |    6 +-----
 arch/hexagon/include/asm/bitops.h |    4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -24,6 +24,7 @@
 
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
+#include <asm/barrier.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define atomic_set(v, i)	((v)->counter = (i))
@@ -163,9 +164,4 @@ static inline int __atomic_add_unless(at
 #define atomic_inc_return(v) (atomic_add_return(1, v))
 #define atomic_dec_return(v) (atomic_sub_return(1, v))
 
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
-
 #endif
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -25,12 +25,10 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
+#include <asm/barrier.h>
 
 #ifdef __KERNEL__
 
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
-
 /*
  * The offset calculations for these are based on BITS_PER_LONG == 32
  * (i.e. I get to shift by #5-2 (32 bits per long, 4 bytes per access),

