From: Jon Pry <jonpry@gmail.com>
Subject: Re: Serious error in the code
Date: Tue, 5 Mar 2013 15:38:33 -0500
Message-ID: <CA+3xLx4whFXnzOOBxxPr3rJF=tD-e+tpME4eb3oeq=VjJq+UOA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=X6lAyCfCoW889XZiP88O06vaGztDqfw02IhERwSt5Ss=;
        b=GG4PodWHsqdzbcxSE7IJLQEyS1+wdz08FSquO3ng1rCeQStcE9iX3PIQkAqvfDsa8y
         uQ4SV+d3mAEZVV7uk91QDD6fx3jhG8L86OZtt0oxM5JNUGfUeG4AxszrBzAcuK7MhNJX
         YxfyJP73sFysrNgZ+t9JjjzO11d78CeEN7kNMRAO5YgnPhiUhZG1/oZYoh19hOu6UtVJ
         I+od91ht92/8Stmw5/VeoLlzeYraN18wG8/GjpXLd4q94YszPhk9fEESB3goQgmrZ5e+
         YC/tEJCkSUy97n2zdCN2qsVV79brob5+WJNq8Z/o0IGimlbY5fhTjuXMl0j7jMRIlCvV
         e5DA==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org

> Well, the meta-issue is that he has code that runs on bare-metal
> hexagon, without the hypervisor, and the question becomes "should
> this code be accepted and merged?" (I think the answer is yes) and
> "how?" (I'm thinking this would be with ifdef's and CONFIG_HVM)
> and finally, "when?" (he claims not to be ready yet, with cleanup required.
> but I'm very much in the "push early and push often" camp).

Originally we thought that the "bare metal" hexagon port would be
substantially different from HVM. To the extent that #ifdef's would
not be possible. But with the recent developments about the processors
strange behavior in supervisor mode, it now seems like our kernel will
be very similar to the HVM port. This new code is just being written
though. Everything is broke, so we will at least need some time before
any patches can be proposed. I am personally interested in trying to
upstream some of this work. Any advice from the community on how it
should be architected and what will be acceptable or not would be
welcome.

Regards,

Jon Pry
