Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDC1EE354
	for <lists+kvmarm@lfdr.de>; Thu,  4 Jun 2020 13:21:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 058AA4B205;
	Thu,  4 Jun 2020 07:21:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7Wh1R45-5gq; Thu,  4 Jun 2020 07:21:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4ABE4B1F8;
	Thu,  4 Jun 2020 07:21:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 274624B1E7
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 07:21:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id moi1WB8akLqP for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Jun 2020 07:21:26 -0400 (EDT)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 167404B1B8
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 07:21:26 -0400 (EDT)
Received: by mail-lj1-f196.google.com with SMTP id z9so6746380ljh.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 04 Jun 2020 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=gVooRWMhJgCNGUc1NJdQ94LBX3KPcfax/TQvcimbeEw=;
 b=p0rNkLGjRPyz2Bo2HFNTHtsVoJ8cARAUozF24TH9g1YlbjCcI4Zj7tYIi3cSlqJf1G
 J9iCkuAAccjpR+eYnB5AtBPXWEFUnHYsq5ljBMyrUJq+8E9epWXcVonbiYLdRgK4Oapd
 bawWxlLtDIuhmxvzZI21bn9JN8xIXkqQ4p+jZ31jrhJFTGZEHsoYcIyL0TOirB3WBpdH
 Dc64xKZGmJxgnZJkNsi/Eg3D+y7CfFHgYQRozqnEeSeJ1WTC2CJ8C+f6lJs1vfzo09uv
 cQWr/cJu/abcu4/Z7pzV9ucEm9r7ihliTE/+3KvfrF9VrtKnhenx5KDAZVwd1MBbjH27
 cgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gVooRWMhJgCNGUc1NJdQ94LBX3KPcfax/TQvcimbeEw=;
 b=sYPdFY0TiGJW5C5dCZkC/HEwz0Q8iP5xcCwJVDfYEkC5nYsHpSGs38uONWPPLyjs+L
 UqrL+LKILfDntNT8ydI/gaqYgK1QcUPH8503Px3tCOx9gNcLxLypS39FeM+7PK6ONAti
 CnLxdldZs/67aTMjSG/fmE4wIBaD07zYde7n6eWiMP0776FNfDoWO+018yoFkqJZOarA
 AaaVj4qMNTmYSCKe5/PTcuDQHSAPh62lGGeaoI1IzOkCY8iPAYJjErTKtZxpZwcHfT49
 7Lprfm+J/7sZE7BEaCvG07PYvThTgzABu4SAGr0VkKNN9WlytvaXiRA6Od5AXXJJtjLO
 5a+A==
X-Gm-Message-State: AOAM531PwsS8Ms9vUKri9mb5rV0xbfcu2oSPxifibYWQJWZdFo75ThFf
 laSm2JXYPxoR9xrAFhFi5o955PYSoFecD83j7d4iK3wq
X-Google-Smtp-Source: ABdhPJzGQz3yr91ECMGq3v8OxFW5w7bm8XGyftFSEbTGxaeRcnY+i0Rq2k0CVULD2lrwb1QKVtBfuZBKzI2dNouDUjw=
X-Received: by 2002:a2e:998c:: with SMTP id w12mr2024650lji.143.1591269684187; 
 Thu, 04 Jun 2020 04:21:24 -0700 (PDT)
MIME-Version: 1.0
From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 4 Jun 2020 14:21:12 +0300
Message-ID: <CAE=Ncrb80uS5wtAu6e1Gctnu8tjcBEpWd7zHJv7aHdEkipe2FQ@mail.gmail.com>
Subject: randomly firing kvm_arch_timer_handler
To: kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi,

I have an issue on one particular hardware with gicv3 and the old
stable (4.9.22x) kernel where the timer interrupt randomly leaks to
the host after the guest exit and the kvm_arch_timer_handler gets
triggered. The guest does run, but the whine (unexpected interrupt) is
annoying and it seems to be hindering the performance drastically - of
both the host and the guest. This behavior can even lead to the host
watchdog biting as the firing timer prevents the progress, especially
during the very early boot when the guest is doing heavy paging
anyway.

Based on the comment in the latest code the fundamental issue is that
the interrupt controller does not recognize the timer disable fast
enough on guest exit. Has anyone worked on a proper fix for the issue
for the old stable series? 5+ kernels seem to have quite a drastic
rework on this front. Plain 'isb' did not seem to do the trick after
the timer disable...


--
Janne
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
