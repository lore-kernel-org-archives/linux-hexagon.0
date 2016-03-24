From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] exit_thread: accept a task parameter to be exited
Date: Thu, 24 Mar 2016 15:36:58 +0000
Message-ID: <20160324153658.GU19428@n2100.arm.linux.org.uk>
References: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NAKSPG7PDxWNTRzT8eeeyXgk7QQAxNM+pQq+uuDQ+3E=;
        b=MmlhFawqWP4SpdnsZisGViB0tVTSy+NiD2cPFB597lCmQkG/9+BfQwPbWwq7mIw/U3kVeNeGTPxCR0jDcTZe8UjRYfrNMhtrLU7GoKZB9x6dx+yyX8Iz3Q+8g/yDKS8y0Zh5EUWtPqED7W0PdZMMEMYVjc8UcrGC923dT/FSBzw=;
Content-Disposition: inline
In-Reply-To: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
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
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, Mar 24, 2016 at 01:58:13PM +0100, Jiri Slaby wrote:
> We need to call exit_thread from copy_process in a fail path.  So make
> it accept task_struct as a parameter.

Hmm, so what this means is that exit_thread() can now be called for
threads which are not running on the CPU.  So, I think the comment
in arch/arm/vfp/vfpmodule.c needs to be updated:

 *  THREAD_NOTIFY_EXIT
 *   - the thread (v) will be running on the local CPU, so
 *      v === current_thread_info()

along with this change, since that becomes false.

The code, however, looks like it'll cope just fine with that being
false, as will the other users of THREAD_NOTIFY_EXIT in ARM.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

