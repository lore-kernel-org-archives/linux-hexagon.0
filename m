From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 3/4] exit_thread: accept a task parameter to be exited
Date: Thu, 24 Mar 2016 14:05:03 +0100
Message-ID: <56F3E5FF.9030105@suse.cz>
References: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
 <20160324130303.GS6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20160324130303.GS6356@twins.programming.kicks-ass.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: <linux-hexagon.vger.kernel.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Content-Type: text/plain; charset="us-ascii"
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>

On 03/24/2016, 02:03 PM, Peter Zijlstra wrote:
> On Thu, Mar 24, 2016 at 01:58:13PM +0100, Jiri Slaby wrote:
>>  void
>> -exit_thread(void)
>> +exit_thread(struct task_struct *me)
>>  {
>>  }
> 
> task_struct arguments are called: tsk, task, p
> 'me' seems very wrong, as that could only mean 'current', and its
> clearly not that.

Ah, OK. I will wait for more feedback and will fix this.

thanks,
-- 
js
suse labs

